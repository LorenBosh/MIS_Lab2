/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendDailyJokeNotification = functions.pubsub
    .schedule("0 15 * * *")
    .timeZone("Europe/Skopje")
    .onRun(async (context) => {
      const message = {
        notification: {
          title: "Joke of the Day!",
          body: "Open the app to see today’s hilarious joke!",
        },
        topic: "dailyJokes",
      };

      try {
        await admin.messaging().send(message);
        console.log("Notification sent successfully.");
      } catch (error) {
        console.error("Error sending notification:", error);
      }
    });


// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
