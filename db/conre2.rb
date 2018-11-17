# coding: UTF-8
e2 = Election.where('nome LIKE ?', "%CONRE-2%").first

# Candidatos CONRE-2

c21 = Candidate.create(nome: "EDSON MANDARINO SANTOS".titleize, election: e2)
c22 = Candidate.create(nome: "ELISABETH BORGES GONÇALVES".titleize, election: e2)
c23 = Candidate.create(nome: "JOSÉ RONALD NORONHA LEMOS".titleize, election: e2)


# Eleitores CONRE-2

pass = "$2a$10$VUV4fDA3cA.MqOMQsus1BejyOUJRR1VpjwhzaY79EBW5ehO74wu0."

Person.create(nome: "master2", email: "", conselho: "CONRE2", documento: "master2", election: e2, password_digest: BCrypt::Password.create("master2"))

Person.create(nome: "TESTE1", conselho: "CONRE2", documento: "29999", election: e2, senha: "Anderson", email: "andycds@gmail.com", password_digest: BCrypt::Password.create("Anderson"))
Person.create(nome: "TESTE2", conselho: "CONRE2", documento: "29998", election: e2, senha: "Anderson", email: "andycds@gmail.com", password_digest: BCrypt::Password.create("Anderson"))

textoEleitores = "#{Rails.root}/db/eleitores2.bin"
File.foreach(textoEleitores) { |x|
	pessoa = x.split("\t")
	Person.create(nome: pessoa[2].titleize, conselho: "CONRE2", documento: pessoa[0].strip, election: e2, password_digest: BCrypt::Password.create(pessoa[1]), email: pessoa[4].gsub(/[^0-9A-Za-z.@]/, ''), apto_votar: pessoa[3].chomp == "TRUE", senha: pessoa[1])
}
