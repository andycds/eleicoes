# coding: UTF-8
e2 = Election.where('nome LIKE ?', "%CONRE-2%").first

# Candidatos CONRE-2

c21 = Candidate.create(nome: "EDSON MANDARINO SANTOS".titleize, election: e2)
c22 = Candidate.create(nome: "ELISABETH BORGES GONÇALVES".titleize, election: e2)
c23 = Candidate.create(nome: "JOSÉ RONALD NORONHA LEMOS".titleize, election: e2)


# Eleitores CONRE-2

pass = "$2a$10$VUV4fDA3cA.MqOMQsus1BejyOUJRR1VpjwhzaY79EBW5ehO74wu0."

textoEleitores = "#{Rails.root}/db/eleitores2.bin"

Person.create(nome: "master", email: "", conselho: "CONRE2", documento: "master", election: e2, password_digest: BCrypt::Password.create("master"))

File.foreach(textoEleitores) { |x|
	pessoa = x.split("\t")
	Person.create(nome: pessoa[2].titleize, conselho: "CONRE2", documento: pessoa[0].strip, election: e2, password_digest: BCrypt::Password.create(pessoa[1]), email: pessoa[4].gsub(/[^0-9A-Za-z.@]/, ''), apto_votar: pessoa[3].chomp == "TRUE", senha: pessoa[1])
}
