# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

class Object
  def with(&block)
    self.instance_eval(&block)
    self
  end
end

require 'csv'
CSV.foreach("public/BioMart_Ensembl_Plant_Gene_49_TAIR10.txt", headers: true, col_sep: "\t") do |e|
  #<CSV::Row "Gene stable ID":"AT3G11415" "Transcript stable ID":"AT3G11415.1" "GO domain":nil "GO term name":nil "GO term accession":nil "GO term definition":nil "Gene name":nil "Gene description":nil>
  gid = e["Gene stable ID"]
  tid = e["Transcript stable ID"]
  name = e["Gene name"]
  description = e["Gene description"]
  go_domain = e["GO domain"]
  go_term_name = e["GO term name"]
  go_term_accession = e["GO term accession"]
  go_term_definition = e["GO term definition"]
  gene = Gene.new.with do 
    send("gid=", gid)
    send("tid=", tid)
    send("name=", name)
    send("description=", description)
    send("GO_domain=", go_domain)
    send("GO_term_name=", go_term_name)
    send("GO_term_accession=", go_term_accession)
    send("GO_term_definition=", go_term_definition)
  end
  gene.save
end

