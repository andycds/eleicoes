require 'sendgrid-ruby'
#include SendGrid

class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :redirecionar_sem_acesso?

  # GET /people
  # GET /people.json
  def index
    #@people = Person.all
    #@people = Person.where.not(documento: current_user.documento).and(.order(:documento)
    @people = Person.where("conselho = ? and documento not ilike 'master%'", current_user.conselho)
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  #def habilitar
    #print "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!111"
    #@person.apto_votar = !@person.apto_votar
    #nada = @person.save
    #render action: "index"
    #format.html { redirect_to :index }
  #end
  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    #if @person.update(params[:person])
    if @person.update(person_params)
      redirect_to '/people'
    else
      render 'edit'
    end
  end

  def habilitar
    @person.apto_votar = !@person.apto_votar
    @person.save
    redirect_to '/people'
    ##@people = Person.where.not(documento: current_user.documento)
    ##render :index
    #respond_to do |format|
    #  if @person.update(person_params)
    #    format.html { redirect_to @person, notice: 'Person was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @person }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @person.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    sender = @person.conselho == "CONRE2" ? "eleicoes@conre2.org.br" : "eleicoes@conre4.org.br"
    from = SendGrid::Email.new(email: 'eleicoesCONRE@CONRE')
    subject = 'ELEIÇÕES 2018 - CONRE'
    to = SendGrid::Email.new(email: @person.email)
    login = @person.documento[1, @person.documento.size]
    sua_senha_eh = "<html><body><p>" +
      "Prezado(a)</p>" +
      "<p></p>" +
      "<p>Estamos encaminhando a seguir o seu login e a sua senha para que você possa exercer o seu direito de votação:</p>" +
      "<p></p>" +
      "<p><b>LOGIN: " + login + "</b></p>" +
      "<p><b>SENHA: " + @person.senha.to_s +  "</b></p>" +
      "<p><a href='https://eleicoes.herokuapp.com/'>https://eleicoes.herokuapp.com/</a></p>" +
      "<p></p>" +

      "<p><b>Obs: login/senha são informações individuais de inteira única e exclusiva responsabilidade do eleitor. Em caso de perda do login/senha entre em contato com o seu CONRE</b></p>" +
      "<p>Exerça o seu direito e vote pela internet. Sua participação no processo eleitoral é muito importante.</p>".to_s

    content = SendGrid::Content.new(type: 'text/html', value: sua_senha_eh)
    mail = SendGrid::Mail.new(from, subject, to, content)
    send_gri_api_key = ENV['SENDGRID_API_KEY']
    if (!send_gri_api_key.nil?)
      sg = SendGrid::API.new(api_key: send_gri_api_key)
      response = sg.client.mail._('send').post(request_body: mail.to_json)
    end
    redirect_to '/people'
    #@person.destroy
    #respond_to do |format|
    #  format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  def redirecionar_sem_acesso?
    redirect_to '/login' unless (current_user != nil && !current_user.documento.start_with?("master"))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      #params.fetch(:person, {})
      params.require(:person).permit(:documento, :email, :nome, :apto_votar)
    end
end