# coding: UTF-8
e2 = Election.where('nome LIKE ?', "%CONRE-2%").first

# Candidatos CONRE-2

c21 = Candidate.create(nome: "Carlos Alberto Castelo Fonseca", election: e2)
c22 = Candidate.create(nome: "Herich Ulrich", election: e2)
c23 = Candidate.create(nome: "Luiz Gonzaga de Souza Dutra", election: e2)



# Eleitores CONRE-2

pass = "$2a$10$VUV4fDA3cA.MqOMQsus1BejyOUJRR1VpjwhzaY79EBW5ehO74wu0."

textoEleitores = "#{Rails.root}/db/eleitores2.bin"
File.foreach(textoEleitores) { |x|
	pessoa = x.split("\t")
	Person.create(nome: pessoa[2].titleize, conselho: "CONRE2", documento: pessoa[0], election: e2, password_digest: BCrypt::Password.create(pessoa[1]))
}
