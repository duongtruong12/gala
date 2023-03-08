const admin = require('firebase-admin');
const functions = require("firebase-functions");
const stripe = require("stripe")("sk_test_51McKsOIx8zBC2fSmofXLDyeplkqahxIVSDvxnOPMmODotm0gMnR7QkchaonOgucWPjovZwZfmzQIjl83RuOWqVWA00And2NmwO");
const cors = require('cors')({origin: true});
const nodemailer = require("nodemailer");
let transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
        user: "claha.sp.ja@gmail.com",
        pass: "hugkpuqxzipignun",
    },
});

admin.initializeApp();
exports.notificationListener = functions.region('asia-northeast1').firestore.document("/notification/{messageGroupId}/itemsNotification/{itemId}")
    .onCreate(async (snapshot) => {
        sendNotification(snapshot.data());
    });

function sendNotification(item) {
    const title = item["title"];
    const body = item["body"];
    const list = item["listToken"];
    const listEmail = item["listEmail"];

    list.forEach(sendNotificationThroughToken);
    listEmail.forEach(sendEmail);

    async function sendEmail(email) {
        console.log("Send Email To:", email);
        let mailOptions = {
            from: '"Claha" <claha.sp.ja@gmail.com>',
            to: email,
            subject: title,
            html: `
        <html lang="ja">
            <head>
                <title>${title}</title>
            </head>
            <body>
                <h1>${body}</h1>
                <p>素晴らしい一日をお過ごしください。</p>
            </body>
        </html>
    `
        };

        transporter
            .sendMail(mailOptions)
            .then((info) => {
                console.log("Message sent: %s", info.messageId);
            });
    }

    async function sendNotificationThroughToken(token) {
        const message = {
            notification: {
                title: title,
                body: body,
            },
            token: token,
        };

        admin
            .messaging()
            .send(message)
            .then((_) => {
                console.log("Send Notification to token: ", token);
            })
            .catch((error) => {
                console.log("Error Send Notification:", error);
            });
    }
}

exports.stripePaymentIntentRequest = functions.region('asia-northeast1').https.onRequest(async (req, res) => {
    return cors(req, res, async () => {
        try {
            let customerId;

            //Gets the customer who's email id matches the one sent by the client
            const customerList = await stripe.customers.list({
                email: req.body.email,
                limit: 1
            });

            //Checks the if the customer exists, if not creates a new customer
            if (customerList.data.length !== 0) {
                customerId = customerList.data[0].id;
            } else {
                const customer = await stripe.customers.create({
                    email: req.body.email
                });
                customerId = customer.data.id;
            }

            //Creates a temporary secret key linked with the customer
            const ephemeralKey = await stripe.ephemeralKeys.create(
                {customer: customerId},
                {apiVersion: '2020-08-27'}
            );

            //Creates a new payment intent with amount passed in from the client
            const paymentIntent = await stripe.paymentIntents.create({
                amount: parseInt(req.body.amount),
                currency: 'JPY',
                customer: customerId,
                payment_method_types: ['card'],
            })
            res.set('Access-Control-Allow-Origin', '*');
            res.set('Access-Control-Allow-Methods', 'GET, PUT, POST, OPTIONS');
            res.set('Access-Control-Allow-Headers', '*');
            res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
            res.setHeader("Access-Control-Allow-Origin", "*")
            res.setHeader('Access-Control-Allow-Credentials', true)
            res.status(200).send({
                paymentIntent: paymentIntent.client_secret,
                ephemeralKey: ephemeralKey.secret,
                customer: customerId,
                success: true,
            })

        } catch (error) {
            res.status(404).send({success: false, error: error.message})
        }
    });
});