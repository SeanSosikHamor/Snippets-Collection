# Sean Sosik-Hamor's Snippets for Squarespace and Google

These snippets act as triggers to process Squarespace forms submitted to Google Sheets. Once a form is submitted, these scripts trigger and email a formatted version that's more appealing than Squarespace's default email.

To enable a Google Sheet, select Tools → Script editor, and paste the script in (after modifying for your specific columns). Then, from the Google Apps Script dashboard, create a trigger: sendEmails → From spreadsheet → On change → Notify me immediately.

The script will require authorization to send email via your Google account the first time it is run or debug. Additionally, the MailApp.sendEmail function does not allow for setting a From: header, as it will always send using the email address of the Google account owner. This is a security precaution. The GmailApp.sendEmail function does allow setting a From:, but it grants much wider permissions to your Gmail account.

If you'd rather the script not send email as you, create a role account within Gmail or G Suite specifically for scripts like this. 
