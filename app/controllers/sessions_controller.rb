class SessionsController < ApplicationController
	def new
		@title = 'versão 3.1.2'
	end
	def create
		@person = Person.find_by_documento(params[:session][:documento])
		if @person && @person.authenticate(params[:session][:password]) && @person.election.valida?
			session[:person_id] = @person.id
			redirect_to '/'
		else
			#redirect_to 'login'
			if @person && @person.authenticate(params[:session][:password])
				flash[:notice] = "Fora do prazo para votação." #+" ----" + @person.election.dt_inicio.in_time_zone('Brasilia').to_s + "-------" + @person.election.dt_fim.in_time_zone('Brasilia').to_s + "-------" + Time.now.in_time_zone('Brasilia').to_s
			else
				flash[:notice] = "Erro no documento/senha."
			end
   			render 'new'
		end
	end
  
	def destroy
		session[:person_id] = nil
		flash[:notice] = "Logout efetuado."
		redirect_to '/login'
	end
end
