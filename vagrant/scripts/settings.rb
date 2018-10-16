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

                config.vm.provision "shell" do |s|
                    s.name = "Creating Site: " + site["map"]
                    if site.include? 'params'
                        params = "("
                        site["params"].each do |param|
                            params += " [" + param["key"] + "]=" + param["value"]
                        end
                        params += " )"
                    end
                    s.path = scriptDir + "/nginx-serve.sh"
                    s.args = [site["map"], site["to"], site["port"] ||= "80", site["ssl"] ||= "443", site["php"] ||= "7.2", params ||= "", site["zray"] ||= "false"]

                    if site["zray"] == 'true'
                        config.vm.provision "shell" do |s|
                            s.inline = "ln -sf /opt/zray/gui/public " + site["to"] + "/ZendServer"
                        end
                        config.vm.provision "shell" do |s|
                            s.inline = "ln -sf /opt/zray/lib/zray.so /usr/lib/php/20170718/zray.so"
                        end
                        config.vm.provision "shell" do |s|
                            s.inline = "ln -sf /opt/zray/zray.ini /etc/php/7.2/fpm/conf.d/zray.ini"
                        end
                    else
                        config.vm.provision "shell" do |s|
                            s.inline = "rm -rf " + site["to"] + "/ZendServer"
                        end
                    end
                end

            end
        end


    end
end
