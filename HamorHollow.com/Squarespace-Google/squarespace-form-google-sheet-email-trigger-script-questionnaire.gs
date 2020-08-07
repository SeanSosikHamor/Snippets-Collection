/* Google Sheet email trigger script for processing Squarespace forms. */
/* By: Sean Sosik-Hamor <sean@hamor.com> */
/* Adapted from original script by: scripts@bryanp.com */

function sendEmails() {
  var emailRecipient = "noreply@hamorhollow.com";    // Primary recipient of contact form.
  var emailRecipientBcc = "noreply@hamorhollow.com"; // Webmaster for troubleshooting.

  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var s = ss.getActiveSheet();
  var values = s.getDataRange().getValues();

  for (var row = 1; row < values.length; row++) {
    if (values[row][0] && !values[row][18])  {       // If date ([row][0] Cell A) has a value and row not previously sent ([row][18] Cell S) then send email.
      var strSubmittedOn = values[row][0];           // Row Cell A
      var strEnquirerName = values[row][1];          // Row Cell B
      var strEnquirerEmail = values[row][2];         // Row Cell C
      var strEnquirerConfirmEmail = values[row][3];  // Row Cell D
      var strMobile = values[row][4];                // Row Cell E
      var strAddress = values[row][5];               // Row Cell F
      var strWhy = values[row][6];                   // Row Cell G
      var strWhere = values[row][7];                 // Row Cell H
      var strHow = values[row][8];                   // Row Cell I
      var strWho = values[row][9];                   // Row Cell J
      var strCurrentHedgie = values[row][10];        // Row Cell K
      var strOtherAnimals = values[row][11];         // Row Cell L
      var strStories = values[row][12];              // Row Cell M
      var strCareFor = values[row][13];              // Row Cell N
      var strEnclosure = values[row][14];            // Row Cell O
      var strFood = values[row][15];                 // Row Cell P
      var strBreeding = values[row][16];             // Row Cell Q
      var strComments = values[row][17];             // Row Cell R
      var strSent = values[row][18];                 // Row Cell S changes from null to "Sent" after email is successfully sent.
      var strCustomSubject = "[Hamor Hollow] - Questionnaire - " + strEnquirerName;

      MailApp.sendEmail({
        replyTo: strEnquirerEmail,
        name: "Hamor Hollow Questionnaire",
        to: emailRecipient,
        bcc: emailRecipientBcc,
        subject: strCustomSubject,
        htmlBody: "<b>Name:</b> " + strEnquirerName + "<br>" +
        "<b>Email:</b> " + strEnquirerEmail + "<br>" +
        "<b>Email:</b> " + strEnquirerConfirmEmail + "<br>" +
        "<b>Mobile Number:</b> " + strMobile + "<br>" +
        "<b>Address:</b> " + strAddress + "<br><br><br>" +
        "<b>Why do you want a hedgie as a companion?</b><br><br>" + strWhy + "<br><br><br>" +
        "<b>Where did you hear about Hamor Hollow?</b><br><br>" + strWhere + "<br><br><br>" +
        "<b>How soon are you looking for a hedgie to join your family?</b><br><br>" + strHow + "<br><br><br>" +
        "<b>Who will be the primary caregiver for the hedgie?</b><br><br>" + strWho + "<br><br><br>" +
        "<b>Is a hedgie is a current member of your family?</b><br><br>" + strCurrentHedgie + "<br><br><br>" +
        "<b>Please list any other animals that are a part of your family.</b><br><br>" + strOtherAnimals + "<br><br><br>" +
        "<b>Do you have any stories about your previous hedgehog experience?</b><br><br>" + strStories + "<br><br><br>" +
        "<b>Are you willing to care for your hedgehog throughout its entire lifespan regardless of veterinary bills or difficulties?</b><br><br>" + strCareFor + "<br><br><br>" +
        "<b>What type of enclosure will your hedgie call home? Please describe including dimensions toys accessories and exercise wheel.</b><br><br>" + strEnclosure + "<br><br><br>" +
        "<b>What pet food brands were you considering Or would you be purchasing Hamor Hollows blended mix of dry pet foods?</b><br><br>" + strFood + "<br><br><br>" +
        "<b>Do you ever plan on breeding your hedgehog?</b><br><br>" + strBreeding + "<br><br><br>" +
        "<b>Do you have any questions or comments?</b><br><br>" + strComments,
      });

      s.getRange(row + 1, 19).setValue('Sent');      // Sets Row Cell S (values[row][18]) to "Sent" once email is sent. This is an intentional off-by-one. Setting 19 here actually sets values[row][18].
    }
  }
}
