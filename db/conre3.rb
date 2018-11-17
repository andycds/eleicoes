# coding: UTF-8
e3 = Election.where('nome LIKE ?', "%CONRE-3%").first

# Candidatos CONRE-3

c31 = Candidate.create(nome: "ADRIANA MARIA MARQUES DA SILVA", election: e3)
c32 = Candidate.create(nome: "ANGELA TAVARES PAES", election: e3)
c33 = Candidate.create(nome: "JULIO ADOLFO ZUCON TRECENTI", election: e3)
c34 = Candidate.create(nome: "MARCUS EMMANUEL SOARES DE ARAUJO", election: e3)
c35 = Candidate.create(nome: "NARA REGINA SPALL MARTINS", election: e3)


#c31 = Candidate.create(nome: "MARCELO VENTURA FREIRE", election: e3)
#c32 = Candidate.create(nome: "MARCOS ANTONIO COQUE JUNIOR", election: e3) 
#c33 = Candidate.create(nome: "MAURO CORREIA ALVES", election: e3)
#c34 = Candidate.create(nome: "NATHÁLIA DEMETRIO VASCONCELOS MOURA", election: e3)
#c35 = Candidate.create(nome: "PAULO CESAR FERREIRA LIMA", election: e3)
#c36 = Candidate.create(nome: "REGINA ALBANESE POSE", election: e3)

    
# Eleitores CONRE-3

pass = "$2a$10$VUV4fDA3cA.MqOMQsus1BejyOUJRR1VpjwhzaY79EBW5ehO74wu0."

Person.create(nome: "master3", email: "", conselho: "CONRE3", documento: "master3", election: e3, password_digest: BCrypt::Password.create("master3"))

Person.create(nome: "TESTE1", conselho: "CONRE3", documento: "39999", election: e3, senha: "Anderson", email: "andycds@gmail.com", password_digest: BCrypt::Password.create("Anderson"))
Person.create(nome: "TESTE2", conselho: "CONRE3", documento: "39998", election: e3, senha: "Anderson", email: "andycds@gmail.com", password_digest: BCrypt::Password.create("Anderson"))

textoEleitores = "#{Rails.root}/db/eleitores3.bin"
File.foreach(textoEleitores) { |x|
	pessoa = x.split("\t")
	Person.create(nome: pessoa[2].titleize, conselho: "CONRE3", documento: pessoa[0], election: e3, password_digest: BCrypt::Password.create(pessoa[1]))
}
