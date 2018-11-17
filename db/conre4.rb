# coding: UTF-8
e5 = Election.where('nome LIKE ?', "%CONRE-4%").first

# Candidatos CONRE-4

c51 = Candidate.create(nome: "Gabriel Afonso Marchesi Lopes".titleize, election: e5)
c52 = Candidate.create(nome: "Marilene Dias Bandeira".titleize, election: e5)

# Eleitores CONRE-4

pass = "$2a$10$VUV4fDA3cA.MqOMQsus1BejyOUJRR1VpjwhzaY79EBW5ehO74wu0."

Person.create(nome: "master4", email: "", conselho: "CONRE4", documento: "master4", election: e5, password_digest: BCrypt::Password.create("master4"))

Person.create(nome: "TESTE1", conselho: "CONRE4", documento: "49999", election: e5, senha: "Anderson", email: "andycds@gmail.com", password_digest: BCrypt::Password.create("Anderson"))
Person.create(nome: "TESTE2", conselho: "CONRE4", documento: "49998", election: e5, senha: "Anderson", email: "andycds@gmail.com", password_digest: BCrypt::Password.create("Anderson"))

textoEleitores = "#{Rails.root}/db/eleitores4.bin"
File.foreach(textoEleitores) { |x|
	pessoa = x.split("\t")
	Person.create(nome: pessoa[2].titleize, conselho: "CONRE4", documento: pessoa[0], election: e5, senha: pessoa[1], email: pessoa[3], password_digest: BCrypt::Password.create(pessoa[1]))
}

