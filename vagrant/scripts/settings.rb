class Settings
    def Settings.configure(config, settings)
        
        scriptDir = File.dirname(__FILE__)
        
        if settings.include? 'sites'
            settings["sites"].each do |site|

                # Create SSL certificate
                config.vm.provision "shell" do |s|
                    s.name = "Creating Certificate: " + site["map"]
                    s.path = scriptDir + "/create-certificate.sh"
                    s.args = [site["map"]]
                end

            end
        end
    end
end
