class HomeController < ApplicationController
  def index
  end
  def get_annotation
    # p params
    # p params[:parameters][:atids]
    csv = params[:csv]
    # p csv
    ids_ = params[:parameters][:atids]
    ids = ids_.split
    #p ids
    @headers = ["Gene ID", "Transcript ID(s)", "Name", "GO BP", "GO MF", "GO CC", "Description"]
    @genes = {}
    ids.each do |id|
      genes = if id =~ /\./
                Gene.where(tid: id)
              else
                Gene.where(gid: id)
              end
      genes.each do |gene|
        gid = gene.gid
        @genes[gid] ||= {}
        @genes[gid]["Gene ID"] = gid
        @genes[gid]["GO BP"] ||= []
        @genes[gid]["GO MF"] ||= []
        @genes[gid]["GO CC"] ||= []
        case gene.GO_domain
          when "biological_process"
            @genes[gid]["GO BP"] << gene.GO_term_accession
          when "molecular_function"
            @genes[gid]["GO MF"] << gene.GO_term_accession
          when "cellular_component"
            @genes[gid]["GO CC"] << gene.GO_term_accession
        end
        @genes[gid]["Transcript ID(s)"] ||= []
        @genes[gid]["Transcript ID(s)"] << gene.tid
        @genes[gid]["Name"] ||= gene.name
        @genes[gid]["Description"] ||= gene.description
        #p @genes
      end
    end
    if csv
      require 'csv'
      @csv = CSV.generate("", headers: @headers, write_headers: true, col_sep: ",") do |out|
        @genes.each do |gid, gene|
          row = @headers.map{|col|
            if gene[col].class == Array
              gene[col].uniq.sort.join(";")
            else
              gene[col].to_s
            end
          }
          out << row
        end
      end
      p @csv
      render :get_annotation_csv
    end
  end
end
