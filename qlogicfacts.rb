# Adds Qlogic card facts
puts "Collecting HBA information..."
require 'facter'

if Facter::Core::Execution.exec('where qaucli').empty?
  Facter.add("qlogic") {setcode{'qcc_unavailable'}}
else
  #Adds model#
  puts "Querying Model Information"
  models = Facter::Core::Execution.exec('qaucli -fc -i | find "HBA Model"') #command runs globally so it pulls from all ports
  models.each_line.each_with_index do |line, index| #each_line do the next thing for each line in the return - each_with_index, keep track of the indexes starting at 0 for each line do the next thing with |line, index|
    newmodels = Facter::Core::Execution.exec("qaucli -fc -i #{index} | find \"HBA Model\"").split(':').last.strip #new variable, pass #{index} to it to run on a port level 0,1,2,3etc then strip anything after the :
    Facter.add("qlogicmodel#{index}") do #create a new fact with a name of qlogicmodels + our #{index}
    confine :kernel => :windows
      setcode do
        newmodels #set the value of the fact to what newmodels is
      end
    end
  end
  
  puts "Creating Model Array Fact"
  models = Facter::Core::Execution.exec('qaucli -fc -i | find "HBA Model"')
  modelsarray = []
  models.each_line.each_with_index do |line, index|
    newmodels = Facter::Core::Execution.exec("qaucli -fc -i #{index} | find \"HBA Model\"").split(':').last.strip
    newmodels.split(/\n/).each do |pair|
       modelsarray.push(newmodels)
    end
  end
  Facter.add("qlogicmodel_array") do
  confine :kernel => :windows
    setcode do
      modelsarray
    end
  end

  #Adds driver #
  puts "Querying Driver Information"
  drivers = Facter::Core::Execution.exec('qaucli -fc -i | find "Driver Version"') #command runs globally so it pulls from all ports
  drivers.each_line.each_with_index do |line, index| #each_line do the next thing for each line in the return - each_with_index, keep track of the indexes starting at 0 for each line do the next thing with |line, index|
    newdrivers = Facter::Core::Execution.exec("qaucli -fc -i #{index} | find \"Driver Version\"").split(':').last.strip.gsub(/[A-Za-z ]/, '') #new variable, pass #{index} to it to run on a port level 0,1,2,3etc then strip anything after the :
    Facter.add("qlogicdriver#{index}") do #create a new fact with a name of qlogicdrivers + our #{index}
    confine :kernel => :windows
      setcode do
        newdrivers #set the value of the fact to what newdrivers is
      end
    end
  end

  puts "Creating Driver Array Fact"
  drivers = Facter::Core::Execution.exec('qaucli -fc -i | find "Driver Version"')
  driversarray = []
  drivers.each_line.each_with_index do |line, index|
    newdrivers = Facter::Core::Execution.exec("qaucli -fc -i #{index} | find \"Driver Version\"").split(':').last.strip.gsub(/[A-Za-z ]/, '')
    newdrivers.split(/\n/).each do |pair|
       driversarray.push(newdrivers)
    end
  end
  Facter.add("qlogicdriver_array") do
  confine :kernel => :windows
    setcode do
      driversarray
    end
  end

  #Adds firmware
  puts "Querying Firmware Information"
  firmware = Facter::Core::Execution.exec('qaucli -fc -i | find "Running Firmware Version"') #command runs globally so it pulls from all ports
  firmware.each_line.each_with_index do |line, index| #each_line do the next thing for each line in the return - each_with_index, keep track of the indexes starting at 0 for each line do the next thing with |line, index|
    newfirmware = Facter::Core::Execution.exec("qaucli -fc -i #{index} | find \"Running Firmware Version\"").split(':').last.strip #new variable, pass #{index} to it to run on a port level 0,1,2,3etc then strip anything after the :
    Facter.add("qlogicrunningfirmware#{index}") do #create a new fact with a name of qlogicfirmware + our #{index}
    confine :kernel => :windows
      setcode do
        newfirmware #set the value of the fact to what newfirmware is
      end
    end
  end

  puts "Creating Firmware Array Fact"
  firmwares = Facter::Core::Execution.exec('qaucli -fc -i | find "Running Firmware Version"')
  firmwaresarray = []
  firmwares.each_line.each_with_index do |line, index|
    newfirmwares = Facter::Core::Execution.exec("qaucli -fc -i #{index} | find \"Running Firmware Version\"").split(':').last.strip
    newfirmwares.split(/\n/).each do |pair|
       firmwaresarray.push(newfirmwares)
    end
  end
  Facter.add("qlogicrunningfirmware_array") do
  confine :kernel => :windows
    setcode do
      firmwaresarray
    end
  end

  #Adds the cards serial numbers
  puts "Querying Serial # Information"
  serials = Facter::Core::Execution.exec('qaucli -fc -i | find "Serial Number"') #command runs globally so it pulls from all ports
  serials.each_line.each_with_index do |line, index| #each_line do the next thing for each line in the return - each_with_index, keep track of the indexes starting at 0 for each line do the next thing with |line, index|
    newserials = Facter::Core::Execution.exec("qaucli -fc -i #{index} | find \"Serial Number\"").split(':').last.strip #new variable, pass #{index} to it to run on a port level 0,1,2,3etc then strip anything after the :
    Facter.add("qlogicserial#{index}") do #create a new fact with a name of qlogicserials + our #{index}
    confine :kernel => :windows
      setcode do
        newserials #set the value of the fact to what newserials is
      end
    end
  end

  puts "Creating Serial Array Fact"
  serials = Facter::Core::Execution.exec('qaucli -fc -i | find "Serial Number"')
  serialsarray = []
  serials.each_line.each_with_index do |line, index|
    newserials = Facter::Core::Execution.exec("qaucli -fc -i #{index} | find \"Serial Number\"").split(':').last.strip
    newserials.split(/\n/).each do |pair|
       serialsarray.push(newserials)
    end
  end
  Facter.add("qlogicserial_array") do
  confine :kernel => :windows
    setcode do
      serialsarray
    end
  end

  #Adds bios version
  puts "Querying Bios Information"
  bios = Facter::Core::Execution.exec('qaucli -fc -i | findstr /r "^BIOS Version$\"') #command runs globally so it pulls from all ports
  bios.each_line.each_with_index do |line, index| #each_line do the next thing for each line in the return - each_with_index, keep track of the indexes starting at 0 for each line do the next thing with |line, index|
    newbios = Facter::Core::Execution.exec("qaucli -fc -i #{index} | findstr /r \"^BIOS Version$\"").split(':').last.strip #new variable, pass #{index} to it to run on a port level 0,1,2,3etc then strip anything after the :
    Facter.add("qlogicbios#{index}") do #create a new fact with a name of qlogicbios + our #{index}
    confine :kernel => :windows
      setcode do
        newbios #set the value of the fact to what newbios is
      end
    end
  end

  puts "Creating Bios Array Fact"
  bios = Facter::Core::Execution.exec('qaucli -fc -i | findstr /r "^BIOS Version$\"')
  biosarray = []
  bios.each_line.each_with_index do |line, index|
    newbios = Facter::Core::Execution.exec("qaucli -fc -i #{index} | findstr /r \"^BIOS Version$\"").split(':').last.strip
    newbios.split(/\n/).each do |pair|
       biosarray.push(newbios)
    end
  end
  Facter.add("qlogicbios_array") do
  confine :kernel => :windows
    setcode do
      biosarray
    end
  end

  #Adds FC WWNs
  puts "Querying WWN Information"
  wwns = Facter::Core::Execution.exec('qaucli -fc -i | find "Port Name"') #command runs globally so it pulls from all ports
  wwns.each_line.each_with_index do |line, index| #each_line do the next thing for each line in the return - each_with_index, keep track of the indexes starting at 0 for each line do the next thing with |line, index|
    newwwns = Facter::Core::Execution.exec("qaucli -fc -i #{index} | find \"Port Name\"").split(':').last.strip.gsub(/-/, '') #new variable, pass #{index} to it to run on a port level 0,1,2,3etc then strip anything after the :
    Facter.add("qlogicwwn#{index}") do #create a new fact with a name of qlogicwwns + our #{index}
      setcode do
        newwwns #set the value of the fact to what newwwns is
      end
    end
  end


  puts "Creating WWN Array Fact"
  wwn = Facter::Core::Execution.exec('qaucli -fc -i | find "Port Name"')
  wwnarray = []
  wwn.each_line.each_with_index do |line, index|
    newwwn = Facter::Core::Execution.exec("qaucli -fc -i #{index} | find \"Port Name\"").split(':').last.strip.gsub(/-/, '')
    newwwn.split(/\n/).each do |pair|
       wwnarray.push(newwwn)
    end
  end
  Facter.add("qlogicwwn_array") do
    setcode do
      wwnarray
    end
  end
end

# The following is setup to push all of these facts into hashes, to be used for structured data in puppet.  Foreman does not currently support structured data, so we need to use the above individual facts for now

#This fact collects all the HBA facts and puts them in a hash
# require 'facter'

# if Facter::Core::Execution.exec('where qaucli').empty?
#   Facter.add("qlogicfacts") {setcode{'qcc_unavailable'}}
# else
#   puts "Collecting HBA Information..."

# # Begin Collection
#   Facter.add("qlogicmodels") do
#     setcode do
#       models = Facter::Core::Execution.exec('qaucli -fc -i | find "HBA Model"')
#       modelshash = {}
#       models.each_line.each_with_index do |line, index|
#         newmodels = Facter::Core::Execution.exec("qaucli -fc -i #{index} | find \"HBA Model\"").split(':').last.strip
#         newmodels.split(/\n/).each do |pair|
#           key,value = pair.split(/\n/)
#           modelshash["qlogicmodel#{index}"] = key
#         end
#       end
#       puts "Adding Model Information"
#      modelshash
#     end
#   end
    
#   Facter.add("qlogicfirmwares") do
#     setcode do
#       firmwares = Facter::Core::Execution.exec('qaucli -fc -i | find "Running Firmware Version"')
#       firmwareshash = {}
#       firmwares.each_line.each_with_index do |line, index|
#         newfirmwares = Facter::Core::Execution.exec("qaucli -fc -i #{index} | find \"Running Firmware Version\"").split(':').last.strip
#         newfirmwares.split(/\n/).each do |pair|
#           key,value = pair.split(/\n/)
#           firmwareshash["qlogicfirmware#{index}"] = key
#         end
#       end
#       puts "Adding Firmware Information"
#       firmwareshash
#     end
#   end

#   Facter.add("qlogicdrivers") do
#     setcode do
#       drivers = Facter::Core::Execution.exec('qaucli -fc -i | find "Driver Version"')
#       drivershash = {}
#       drivers.each_line.each_with_index do |line, index|
#         newdrivers = Facter::Core::Execution.exec("qaucli -fc -i #{index} | find \"Driver Version\"").split(':').last.strip.gsub(/[A-Za-z ]/, '')
#         newdrivers.split(/\n/).each do |pair|
#           key,value = pair.split(/\n/)
#           drivershash["qlogicdriver#{index}"] = key
#         end
#       end
#       puts "Adding Driver Information"
#       drivershash
#     end
#   end

#   Facter.add("qlogicserials") do
#     setcode do
#       serials = Facter::Core::Execution.exec('qaucli -fc -i | find "Serial Number"')
#       serialshash = {}
#       serials.each_line.each_with_index do |line, index|
#         newserials = Facter::Core::Execution.exec("qaucli -fc -i #{index} | find \"Serial Number\"").split(':').last.strip
#         newserials.split(/\n/).each do |pair|
#           key,value = pair.split(/\n/)
#           serialshash["qlogicserial#{index}"] = key
#         end
#       end
#       puts "Adding Serial # Information"
#       serialshash
#     end
#   end

#   Facter.add("qlogicbios") do
#     setcode do
#       bios = Facter::Core::Execution.exec('qaucli -fc -i | findstr /r "^BIOS Version$"')
#       bioshash = {}
#       bios.each_line.each_with_index do |line, index|
#         newbios = Facter::Core::Execution.exec("qaucli -fc -i #{index} | findstr /r \"^BIOS Version$\"").split(':').last.strip
#         newbios.split(/\n/).each do |pair|
#           key,value = pair.split(/\n/)
#           bioshash["qlogicbios#{index}"] = key
#         end
#       end
#       puts "Adding Bios Information"
#       bioshash
#     end
#   end

#   Facter.add("qlogicwwns") do
#     setcode do
#       wwns = Facter::Core::Execution.exec('qaucli -fc -i | find "Port Name"')
#       wwnshash = {}
#       wwns.each_line.each_with_index do |line, index|
#         newwwns = Facter::Core::Execution.exec("qaucli -fc -i #{index} | find \"Port Name\"").split(':').last.strip.gsub(/-/, '')
#         newwwns.split(/\n/).each do |pair|
#           key,value = pair.split(/\n/)
#           wwnshash["qlogicwwns#{index}"] = key
#         end
#       end
#       puts "Adding WWN Information"
#       wwnshash
#     end
#   end
