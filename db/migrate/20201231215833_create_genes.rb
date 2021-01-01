class CreateGenes < ActiveRecord::Migration[5.2]
  def change
    create_table :genes do |t|
      t.string :gid
      t.string :tid
      t.string :name
      t.string :description
      t.string :GO_domain
      t.string :GO_term_name
      t.string :GO_term_accession
      t.string :GO_term_definition

      t.timestamps
    end
  end
end
