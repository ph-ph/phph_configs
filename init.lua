-- Various HammerSpoon automations
-- Install from HammerSpoon from https://www.hammerspoon.org/ and place this file into ~/.hammerspoon

function setMacAsDefaultAudioDevice()
   mic = hs.audiodevice.findDeviceByUID("BuiltInMicrophoneDevice") -- use UID instead of name since it's more stable
   if mic then mic:setDefaultInputDevice() end
   speakers = hs.audiodevice.findDeviceByUID("BuiltInSpeakerDevice")
   if speakers then
      speakers:setDefaultOutputDevice()
      speakers:setDefaultEffectDevice()
   end
   if speakers and mic then
      hs.alert.show("Changed input and output to Mac")
   else
      hs.alert.show("Couldn't change input and output to Mac")
   end
end

function setHeadphonesAsDefaultAudioDevice()
   headphonesIn = hs.audiodevice.findInputByName("WH-H900N (h.ear)")
   headphonesOut = hs.audiodevice.findOutputByName("WH-H900N (h.ear)")
   if headphonesIn then headphonesIn:setDefaultInputDevice() end
   if headphonesOut then
      headphonesOut:setDefaultOutputDevice()
      headphonesOut:setDefaultEffectDevice()
   end
   if headphonesIn and headphonesOut then
      hs.alert.show("Changed input and output to Sony headphones")
   else
      hs.alert.show("Couldn't change input and output to Sony headphones")
   end
end

function setScarlettAsDefaultAudioDevice()
   scarlett = hs.audiodevice.findDeviceByName("Scarlett 2i2 USB")
   if scarlett then
      scarlett:setDefaultInputDevice()
      scarlett:setDefaultOutputDevice()
      scarlett:setDefaultEffectDevice()
      hs.alert.show("Changed input and output to Scarlett")
   else
      hs.alert.show("Couldn't change input and output to Scarlett")
   end
end

function displayCurrentAudioDevices()
   input = hs.audiodevice.defaultInputDevice()
   if input then inputName = input:name() else inputName = "None" end
   output = hs.audiodevice.defaultOutputDevice()
   if output then outputName = output:name() else outputName = "None" end
   hs.alert.show(string.format("Input: %s | Output: %s", inputName, outputName))
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "M", setMacAsDefaultAudioDevice)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", setHeadphonesAsDefaultAudioDevice)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "S", setScarlettAsDefaultAudioDevice)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "A", displayCurrentAudioDevices)
