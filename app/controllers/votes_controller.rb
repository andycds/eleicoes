class VotesController < ApplicationController
	before_action :redirecionar_sem_acesso?

	def new
		#if !current_user
		#	redirect_to '/login'
		#	return
		#end
		if current_user.ja_votou?
			redirect_to '/votado'
			return
		end
		
		candidatos = current_user.election.candidates
		@votos = Array.new candidatos.size
		for i in 0...candidatos.size
			@votos[i] = Vote.new(person: current_user, candidate: candidatos[i], election: current_user.election)
		end
	end

	def create
		if current_user.ja_votou?
			redirect_to '/'
			return
		end
		votado = false
		vv = params["votos"]
		if vv != nil
			vv.values.each do |cid|
				c = Candidate.find_by_id(cid)
				v = Vote.new(person: current_user, candidate: c, election: current_user.election)
				v.save
				votado = true
			end
		end
		if votado
			redirect_to '/votado'
			return
		else
			redirect_to '/'
		end
	end

	def votado
		if !current_user
			redirect_to '/login'
			return
		end
		if !current_user.ja_votou?
			redirect_to '/'
			return
		end
		@person = current_user
		@voto = Vote.find_by_person_id(current_user.id) 

		render 'votado'
	end

	def pdfdown
		#if !current_user
		#	redirect_to '/login'
		#	return
		#end
		if !current_user.ja_votou?
			redirect_to '/'
			return
		end
		hora = Vote.find_by_person_id(current_user.id).updated_at
		#agora = Rails.env == 'production' ? (Time.now + 6.hour).to_s : Time.now.to_s
		html = "<!DOCTYPE html><meta charset='UTF-8'><html><head></head><body>"
		html = html + "<h3 style='text-align: center;'>" + current_user.election.cabecalho + "</h3>"
		html = html + "<hr/>" unless current_user.election.cabecalho.empty?
		html = html + "<br/><br/>"
		html = html + "<div style='width: 400px; border: 1px solid gray; margin:20px; padding:20px;'>"
#		html = html + '<p> <img src="http://conre3.heroku.com/images/conre3logo.png" /> </p>'
		html = html + "<p><b>" + current_user.election.nome + "</b></p>"
		html = html + "<p> Comprovante de vota&ccedil;&atilde;o</p> <p>Gerado &agrave;s: " + hora.to_s + "</p>"# + params
		html = html + "<p>Profissional: " + current_user.nome + "</p>"
		html = html + "<p>Login: " + current_user.documento + "</p>"
		html = html + "</div>"
		html = html + "<div style='height: 200px;'></div>"
		html = html + "<hr/>" unless current_user.election.cabecalho.empty?
		html = html + "<p style='font-size: 9px; text-align: center;'>" + current_user.election.rodape + "</p>"
		html = html + "</body></html>"
		pdfkit_instance = PDFKit.new(html)
		send_data(pdfkit_instance.to_pdf, {filename: "comprovante.pdf"})
	end

	private
	def vote_params
		params.require("votos").permit(:content)
	end

	def redirecionar_sem_acesso?
		redirect_to '/login' unless current_user != nil
	end
end
