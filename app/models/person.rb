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
		if self.conselho == "CONRE2"
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
		else
			"<html><body><p>" +
			"Prezado(a) estatístico(a) <b>" + self.nome + "</b>,</p>" +
			"<p>Conforme Instrução 127, de 03 de Setembro de 2019, do Conselho Federal de Estatística (CONFE), informamos que a eleição para renovação de 1/3 " +
			"dos conselheiros do CONRE 4 será das 0h do dia 04/12 até as 20h do dia 05/12. A fim de facilitar a participação, o CONRE 4 " + 
			"fará a eleição de 2019 <b>exclusivamente pela internet</b>." + 
			"<p>Abaixo estão os dados para que você possa acessar o sistema e realizar o seu voto.</p>" +
			"<p></p>" +
			"<p><a href='https://eleicoes.herokuapp.com/'>https://eleicoes.herokuapp.com/</a></p>" +
			"<p><b>LOGIN: " + self.documento.to_s + "</b></p>" +
			"<p><b>SENHA: " + self.senha.to_s + "</b></p>" +
			"<p></p>" +
			"<p>Participe das eleição e ajude a fazermos uma profissão forte e reconhecida.</p>" +
			"<p><b>ATENÇÃO</b>: Por determinação do CONFE, a participação na eleição <b>É OBRIGATÓRIA</b>, e o estatístico que não votar nem " +
			"justificar a sua ausência terá que pagar multa de 50% do valor da anuidade.</p>" +
			"<p>Atenciosamente, </p>" +
			"<p>Gabriel Afonso Marchesi Lopes<br/>" +
			"Presidente do Conselho Regional de Estatística da 4ª Região – PR/SC/RS</p>".to_s
		end
    end

    def subject
    	'ELEIÇÕES 2019 - ' + self.conselho + ' - login e senha'
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
