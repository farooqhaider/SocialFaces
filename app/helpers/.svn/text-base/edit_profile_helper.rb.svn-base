module EditProfileHelper

  #Options for relationship status in editing friends family info
  #The selected option is based on the relationship status of user
  def get_options_for_relationship_status(relationship_status)
    options = StringIO.new
    if (relationship_status.eql?("Single"))
      options << '<option selected="selected">Single</option>'
    else
      options << '<option>Single</option>'
    end

    if (relationship_status.eql?("Engaged"))
      options << '<option selected="selected">Engaged</option>'
    else
      options << '<option>Engaged</option>'
    end
    if (relationship_status.eql?("In a relationship"))
      options << '<option selected="selected">In a relationship</option>'
    else
      options << '<option>In a relationship</option>'
    end
    if (relationship_status.eql?("Its complicated"))
      options << '<option selected="selected">Its complicated</option>'
    else
      options << '<option>Its complicated</option>'
    end
    if (relationship_status.eql?("In an open relationship"))
      options << '<option selected="selected">In an open relationship</option>'
    else
      options << '<option>In an open relationship</option>'
    end
    
    if (relationship_status.eql?("Divorced"))

      options << '<option selected="selected">Divorced</option>'
    else
      options << '<option>Divorced</option>'
    end

    if (relationship_status.eql?("Separated"))
      options << '<option selected="selected">Separated</option>'
    else
      options << '<option>Separated</option>'
    end
      
    return options.string
  end
end
