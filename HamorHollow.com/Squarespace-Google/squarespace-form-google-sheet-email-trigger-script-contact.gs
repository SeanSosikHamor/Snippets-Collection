/* Google Sheet email trigger script for processing Squarespace forms. */
/* By: Sean Sosik-Hamor <sean@hamor.com>                               */
/* Adapted from original script by: scripts@bryanp.com                 */

function sendEmails() {
  var emailRecipient = "noreply@hamorhollow.com";       // Primary recipient of contact form.
  var emailRecipientBcc = "noreply@hamorhollow.com";    // Webmaster for troubleshooting.

  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var s = ss.getActiveSheet();
  var values = s.getDataRange().getValues();

  for (var row = 1; row < values.length; row++) {
    if (values[row][0] && !values[row][6])  {           // If date ([row][0] Cell A) has a value and row not previously sent ([row][6] Cell G) then send email.
      var strSubmittedOn = values[row][0];              // Row Cell A
      var strEnquirerName = values[row][1];             // Row Cell B
      var strEnquirerEmail = values[row][2];            // Row Cell C
      var strSubject = values[row][3];                  // Row Cell D
      var strEnquirerMessage = values[row][4];          // Row Cell E
      var strEnquirerQuestionnaire = values[row][5];    // Row Cell F
      var strSent = values[row][6];                     // Row Cell G changes from null to "Sent" after email is successfully sent.
      var strCustomSubject = "[Hamor Hollow] - Contact - " + strEnquirerName + " - " + strSubject;

      MailApp.sendEmail({
        replyTo: strEnquirerEmail,
        name: "Hamor Hollow Contact",
        to: emailRecipient,
        bcc: emailRecipientBcc,
        subject: strCustomSubject,
        htmlBody: "<b>Name:</b> " + strEnquirerName + "<br>" +
        "<b>Email:</b> " + strEnquirerEmail + "<br>" +
        "<b>Subject:</b> " + strSubject + "<br>" +
        "<b>Message:</b> <br><br>" + strEnquirerMessage,
      });

      s.getRange(row + 1, 7).setValue('Sent');          // Sets Row Cell G (values[row][6]) to "Sent" once email is sent.
                                                        // This is an intentional off-by-one. Setting 7 here actually sets values[row][6].
    }
  }
}
