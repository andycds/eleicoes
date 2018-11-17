class Person < ActiveRecord::Base
	has_secure_password
	belongs_to :election

	def ja_votou?
		return Vote.find_by_person_id(self.id) != nil
	end

	def sender
		self.conselho == "CONRE2" ? "secretaria@conre2.org.br" : "eleicoes@conre4.org.br"
	end

	def body
		"<html><body><p>" +
		"Prezado(a)</p>" +
		"<p>Estamos encaminhando a seguir o seu login e a sua senha para que você possa exercer o seu direito de votação:</p>" +
		"<p></p>" +
		"<p><b>LOGIN: " + self.documento.to_s + "</b></p>" +
		"<p><b>SENHA: " + self.senha.to_s + "</b></p>" +
		"<p><a href='https://eleicoes.herokuapp.com/'>https://eleicoes.herokuapp.com/</a></p>" +
		"<p></p>" +
		"<p>Início: 21/11 às 0h, encerramento: 22/11 às 20h.</p>" +
		"<p><b>Obs: login/senha são informações individuais de inteira, única e exclusiva responsabilidade do eleitor. Em caso de perda do login/senha entre em contato com o CONRE</b></p>" +
		"<p>Exerça o seu direito e vote pela internet. Sua participação no processo eleitoral é muito importante.</p>".to_s
    end

    def subject
    	'ELEIÇÕES 2018 - ' + self.conselho + ' - login e senha'
    end

	def send_email
		if self.email.present? && self.apto_votar
			from = SendGrid::Email.new(email: sender)
    		to = SendGrid::Email.new(email: self.email)
    		login = self.documento
	    	content = SendGrid::Content.new(type: 'text/html', value: body)
    		mail = SendGrid::Mail.new(from, subject, to, content)
    		send_gri_api_key = ENV['SENDGRID_API_KEY']
    		if (!send_gri_api_key.nil?)
      			sg = SendGrid::API.new(api_key: send_gri_api_key)
      			response = sg.client.mail._('send').post(request_body: mail.to_json)
			end
		end
	end
end
