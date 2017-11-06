# coding: UTF-8
e3 = Election.where('nome LIKE ?', "%CONRE-3%").first

# Candidatos CONRE-3

c31 = Candidate.create(nome: "ALESSANDRO ZITO GOMES", election: e3)
c32 = Candidate.create(nome: "DORIS SATIE MARUYAMA FONTES", election: e3) 
c33 = Candidate.create(nome: "FERNANDA CARDOSO ROSA GONÇALVES", election: e3)
c34 = Candidate.create(nome: "INES NOBUKO NISHIMOTO", election: e3)
c35 = Candidate.create(nome: "MARIO HISSAMITSU TARUMOTO", election: e3)
c36 = Candidate.create(nome: "NEWTON NOGUEIRA", election: e3)

    
    

# Eleitores CONRE-3

pass = "$2a$10$VUV4fDA3cA.MqOMQsus1BejyOUJRR1VpjwhzaY79EBW5ehO74wu0."

textoEleitores = "#{Rails.root}/db/eleitores3.bin"
File.foreach(textoEleitores) { |x|
	pessoa = x.split("\t")
	Person.create(nome: pessoa[2].titleize, conselho: "CONRE3", documento: pessoa[0], election: e3, password_digest: BCrypt::Password.create(pessoa[1]))
}
