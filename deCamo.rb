class CamouflageCracker  
  
    def initialize(file)  
        @camoKey = "02957A220CA614E1E1CFBF65206F9EB399654A53FBF67554AD23CD7E9C29E7FCE2F94DD2424E06C0F89A1C623874240055DF41CB01A2B7F38F8ADDAC33836029F378243E7AEBD3E49D9D43944AC7456D2574EB0B98C97CFCC8BA326B00D3C5C29434AFB0E5957D2A84A45FE56E272ADB967E3E483946CF6F71AA3C319AA99E8F8973B339CA32D5F031597C022E8637F92B7E51F241810CD46515F770D4199820BF20B85567CC81188C133C633C9211E45B1B0822604C4AC58AB3C575C3907AF2B2B6C8D0388AC286F0ACE9CA5C4E3E09297829995A84D5BA5ED5927A38FAD060ECF527BAEEB7DE9F9BDE65D47639769CDA688DA8A0A61ED9DB0F4DAB92CD71"  
        @file = file  
        getEncryptedPass()      
    end  
  
    #Read our file byte by byte  
     def getEncryptedPass  
         data = ""  
         File.open(@file).each_byte { |byte|  
             byte = byte.to_s(16).upcase                #convert byte to hex  
             byte = "0" << byte if byte.length == 1            #if the byte is only 1 number add a 0 to the beggining  
             data << "#{byte} "  
         }   
   
         #grab the encypted password out of the file and print it  
         data = data.split("00 02 00").last  
         encryptedPassword = data.split("20 20 20 20 20").first.strip  
   
         puts "\nEncrypted Password = #{encryptedPassword}"  
         decryptPassword(encryptedPassword)  
     end  
       
     def decryptPassword(encrypted)  
         puts "Decrypting..."  
         #put the encrypted password into an array  
         encryptedPasswordArray = encrypted.split(" ")  
         @camoKeyArray = @camoKey.scan(/../)  
   
   
         #for each byte in the array XOR it by the according key byte  
         passwordInHex = ""  
         x = 0  
         while x < encryptedPasswordArray.length  
             passwordInHex << (encryptedPasswordArray[x].to_i(16) ^ @camoKeyArray[x].to_i(16)).to_s(16) << " "  
             x += 1  
         end  
           
         passToAscii(passwordInHex)  
     end  
   
     def passToAscii(hexArray)  
         #convert password to ascii  
         password = ""  
         hexArray = hexArray.split(' ')  
         hexArray.each {|x| password << "\\x" << "#{x}"}  
         password = password.scan(/\\x(..)/).map{|a| a.first.to_i(16).chr}.join  
         puts "Password = #{password}"  
     end  
 end  
   
 #allow file as command line argument  
 if ARGV.length > 0  
     file = ARGV[0]      
     puts "Scanning #{file}"  
 else  
     puts "\nYou must specify a file\n"  
     exit  
 end  
   
 camouflageBuster = CamouflageCracker.new(file) 
