const nodemailer = require('nodemailer');

async function sendEmail(params, callback) {
    try {
        const transporter = nodemailer.createTransport({
            host: 'smtp.gmail.com',
            port: 587,
            auth: {
                user: 'hiremeinindia@gmail.com',
                pass: 'jgbh aqnk yxgp qrol'
            }
        });

        const mailOptions = {
            from: 'prakiya318@gmail.com',
            to: params.email,
            subject: params.subject,
            text: params.body,
        };

        const info = await transporter.sendMail(mailOptions);
        return callback(null, info.response);
    } catch (error) {
        return callback(error);
    }
}

module.exports = {
    sendEmail
};
