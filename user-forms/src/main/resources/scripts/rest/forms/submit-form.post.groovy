import javax.mail.*
import javax.mail.internet.*
import groovy.json.JsonSlurper


class SMTPAuthenticator extends Authenticator {

    public PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication('email@gmail.com', 'password111');
    }
}

def requestJson = request.reader.text
def slurper = new JsonSlurper()
def parsedReq = slurper.parseText(requestJson)

def formItem = siteItemService.getItem(parsedReq[0])
def emailAddress = formItem.queryValue("emailonSubmit")

def message = "";
    message += "<table>"
        for(int i=0; i<=parsedReq.length; i++) {
            def field = parsedReq[i]
            message += "<tr><tr><td>"+field.label+"</td><td>"+field.value+"</td></td>"
        }
    message += "</table>"

def  d_email = emailAddress,
     d_uname = "",
     d_password = "",
     d_host = "smtp.gmail.com",
     d_port  = "465", //465,587
     m_to = emailAddress,
     m_subject = "Form Submission: " + formItem.queryValue("internal-name"),
     m_text = message

def props = new Properties()
props.put("mail.smtp.user", d_email)
props.put("mail.smtp.host", d_host)
props.put("mail.smtp.port", d_port)
props.put("mail.smtp.starttls.enable","true")
props.put("mail.smtp.debug", "true");
props.put("mail.smtp.auth", "true")
props.put("mail.smtp.socketFactory.port", d_port)
props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory")
props.put("mail.smtp.socketFactory.fallback", "false")

def auth = new SMTPAuthenticator()
def session = Session.getInstance(props, auth)
session.setDebug(true);

def msg = new MimeMessage(session)
msg.setText(m_text)
msg.setSubject(m_subject)
msg.setFrom(new InternetAddress(d_email))
msg.addRecipient(Message.RecipientType.TO, new InternetAddress(m_to))

Transport transport = session.getTransport("smtps");
transport.connect(d_host, d_port, d_uname, d_password);
transport.sendMessage(msg, msg.getAllRecipients());
transport.close();