# coding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#t1 = Tag.create(title: "Beaches", image: "http://s3.amazonaws.com/codecademy-content/courses/learn-rails/img/beach01.jpg")
#Destination.create(name: "Ipanema", description: "The beach of Ipanema is known for its elegant development and its social life.", image: "http://s3.amazonaws.com/codecademy-content/courses/learn-rails/img/beach02.jpg", tag_id: t1.id)

#e2 = Election.create(nome: "Elei&ccedil;&atilde;o Teste CONRE-2", dt_inicio: Date.today, dt_fim: Date.today + 10.days)
#e3 = Election.create(nome: "Elei&ccedil;&atilde;o Teste CONRE-3", dt_inicio: Date.today, dt_fim: Date.today + 10.days)
#e5 = Election.create(nome: "Elei&ccedil;&atilde;o Teste CONRE-5", dt_inicio: Date.today, dt_fim: Date.today + 10.days)
e2 = Election.create(nome: "Eleição CONRE-2", dt_inicio: '2018-11-08 01:59:30', dt_fim: '2018-11-30 22:00:00', cabecalho: "", rodape: "")
e3 = Election.create(nome: "Eleição CONRE-3", dt_inicio: '2018-11-08 01:59:30', dt_fim: '2018-11-30 22:00:00', cabecalho: "", rodape: "")
e4 = Election.create(nome: "Eleição CONRE-4", dt_inicio: '2018-11-08 01:59:30', dt_fim: '2018-11-30 22:00:00', cabecalho: "", rodape: "")
#e5 = Election.create(nome: "Eleição CONRE-5", dt_inicio: '2015-12-09 01:59:00', dt_fim: '2015-12-10 22:01:00', cabecalho: "CONSELHO REGIONAL DE ESTATÍSTICA DA<br/>5a REGIÃO", rodape: "Av. Sete de Setembro, 184 – Edf. Sta Rita, Anexo – 4o andar, Sala 406 – São Bento – Salvador/BA – CEP: 40060-001<br/>Tel: (71) 3321-4129 Tel/Fax: (71) 3243-6086 Cel:(71) 8757-5891<br/>E-mail: conre5r@gmail.com")
e8 = Election.create(nome: "Teste -8", dt_inicio: '2018-11-30 18:00:00', dt_fim: '2018-11-30 18:30:00', cabecalho: "", rodape: "")

cbr = Candidate.create(nome: "Voto Branco")
cNu = Candidate.create(nome: "Voto Nulo")



# Candidatos CONRE-8

c81 = Candidate.create(nome: "Candidato 1", election: e8)
c82 = Candidate.create(nome: "Candidato 2", election: e8)
c83 = Candidate.create(nome: "Candidato 3", election: e8)
c84 = Candidate.create(nome: "Candidato 4", election: e8)
c85 = Candidate.create(nome: "Candidato 5", election: e8)
c86 = Candidate.create(nome: "Candidato 6", election: e8)

#123
pass = "$2a$10$VUV4fDA3cA.MqOMQsus1BejyOUJRR1VpjwhzaY79EBW5ehO74wu0."

1.upto(9) do |i|
	Person.create(nome: "Eleitor Teste 8 - #{i}", conselho: "CONRE8", documento: "80000#{i}", election: e8, password_digest: pass)
	#Person.create(nome: "Eleitor CONRE-5 #{i}", conselho: "CONRE5", documento: "50000#{i}", election: e5, password_digest: pass)
end

0.upto(9) do |i|
	Person.create(nome: "Eleitor Teste 8 - #{i}", conselho: "CONRE8", documento: "80001#{i}", election: e8, password_digest: pass)
end
# Eleitores CONRE-2

require "#{Rails.root}/db/conre2.rb"

# Eleitores CONRE-3

#require "#{Rails.root}/db/conre3.rb"

# Eleitores CONRE-4

#require "#{Rails.root}/db/conre4.rb"



#10.upto(99) do |i|
#	Person.create(nome: "Eleitor CONRE-2 #{i}", conselho: "CONRE2", documento: "2000#{i}", election: e2, password_digest: pass)
#	Person.create(nome: "Eleitor CONRE-3 #{i}", conselho: "CONRE3", documento: "3000#{i}", election: e3, password_digest: pass)
#	Person.create(nome: "Eleitor CONRE-5 #{i}", conselho: "CONRE5", documento: "5000#{i}", election: e5, password_digest: pass)
#end


#v1 = Vote.create(person: p9, candidate: c1, election: e1)
#v2 = Vote.create(person: p9, candidate: c2, election: e1)