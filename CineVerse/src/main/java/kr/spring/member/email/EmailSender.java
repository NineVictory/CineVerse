package kr.spring.member.email;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class EmailSender {
	@Autowired
	protected JavaMailSender mailSender;
	
	public void sendEmail(Email email) throws Exception {
        MimeMessage msg = mailSender.createMimeMessage();

        try {
            MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8");
            helper.setFrom(new InternetAddress("movie.cineverse@gmail.com", "CINEVERSE"));	// 이메일 보내는 사람 설정하는데 내가 지정하는 이름으로 발송함
            helper.setTo(email.getReceiver());
            helper.setSubject(email.getSubject());
            helper.setText(email.getContent(), true); // true로 설정하여 HTML을 지원하도록 설정하기

        } catch (MessagingException e) {
            // 예외 발생의 경우
            log.error(e.toString()); // 로그에 찍어 확인하기
        }

        mailSender.send(msg); // 메세지 발송하기
    }
}
