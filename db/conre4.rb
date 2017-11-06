# coding: UTF-8
e5 = Election.where('nome LIKE ?', "%CONRE-4%").first

# Candidatos CONRE-4

c51 = Candidate.create(nome: "Aishameriane Venes Schmidt - Registro: 9270;".titleize, election: e5)
c52 = Candidate.create(nome: "Valéria Dozolina Sartori Bassani - Registro: 6427".titleize, election: e5)
c53 = Candidate.create(nome: "Rafael Bassegio Caumo - Registro: 9036".titleize, election: e5)


# Eleitores CONRE-4

pass = "$2a$10$VUV4fDA3cA.MqOMQsus1BejyOUJRR1VpjwhzaY79EBW5ehO74wu0."

textoEleitores = "#{Rails.root}/db/eleitores4.bin"
File.foreach(textoEleitores) { |x|
	pessoa = x.split("\t")
	Person.create(nome: pessoa[2].titleize, conselho: "CONRE4", documento: pessoa[0], election: e5, password_digest: BCrypt::Password.create(pessoa[1]))
}

