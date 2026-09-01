#!/bin/bash

# IMPORTS
source ./modules.sh

FN_PRINT_GREEN_BANNER "Installing and Configuring Pro Audio Packages for Ubuntu 26.04"

FN_PRINT_YELLOW "This is an interactive script that installs dependencies and runs you through the steps to get everything up and running."

read -p "Press any key to Continue"

if ! [ $(apt list --installed | rg pulseaudio-utils | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "Installing pulseaudio-utils"

  sudo apt install pulseaudio-utils -y

  FN_PRINT_GREEN_BANNER "pulseaudio-utils installed"
else
  FN_PRINT_YELLOW "pulseaudio-utils are already installed"
fi

if ! [ $(apt list --installed | rg pulseaudio-utils | wc -l) = 1 ]; then
  FN_PRINT_YELLOW "Installing PipeWire JACK Utils"

  sudo apt install pipewire-jack qpwgraph jack-example-tools -y

  FN_PRINT_GREEN_BANNER "PipeWire JACK Utils installed"

  FN_PRINT_YELLOW "Configuring Global PipeWire JACK settings for clockrate"

  sudo cp /usr/share/doc/pipewire/examples/ld.so.conf.d/pipewire-jack-x86_64-linux-gnu.conf /etc/ld.so.conf.d/
  sudo ldconfig
else
  FN_PRINT_YELLOW "PipeWire JACK Utils already installed"
fi

FN_PRINT_YELLOW "Audio interfaces are automatically detected by the System but they are not usually set to their pro mode profile. Run the command: wpctl status. This will surface all of your devices detected in the PipeWire layer, you should see your target devices in Sinks and Sources. If they show references to Stereo/SPDIF, you need to configure the devices to pro mode."

read -p "Press any key to Continue"

FN_PRINT_YELLOW "To configure the cards, we will need the card names which you can get by running: pactl list cards short"

read -p "Press any key to Continue"

FN_PRINT_YELLOW "Once we have the card names, for each card you want to configure, run: pactl set-card-profile <CARD_NAME> pro-audio. As a note, the profile name 'pro-audio' will work with most cards but you might need to use a different profile which you should be able to find online."

read -p "Press any key to Continue"

FN_PRINT_YELLOW "Verify the configuration is correct by running: wpctl status again. You should see your cards with a different name and no reference to Stereo/SPDIF, usually with Pro on them."

read -p "Press any key to Continue"

FN_PRINT_YELLOW "Verify that PipeWire's JACK bridge is live by running: pw-jack jack_lsp. This will print a list of ports, you should see <DEVICE_NAME>:<PORT_NAME> for your cards which should display all inputs and outputs available to the device as it is now in Pro Mode."

read -p "Press any key to Continue"

FN_PRINT_YELLOW "Having all devices configured, we need to pin PipeWire's clock on all devices. You need to know what sample rate you want to run in for this step. Some devices have allowed clockrates, so if you wish to use all of them, find one clock-rate that overlaps with all your devices. Once you have your rate you need to run the following command which uses 48000 as the clock rate:"

echo "mkdir -p ~/.config/pipewire/pipewire.conf.d
cat > ~/.config/pipewire/pipewire.conf.d/10-clock.conf <<'EOF'
context.properties = {
    default.clock.rate = 48000
    default.clock.allowed-rates = [ 48000 ]
}
EOF"
FN_PRINT_YELLOW "If you wish to change your clock rate in the future, run the cat section of the above command onward with your new rate."

read -p "Press any key to Continue"

FN_PRINT_YELLOW "Restart PipeWire so it picks up the change with: systemctl --user restart pipewire pipewire-pulse"

read -p "Press any key to Continue"

FN_PRINT_YELLOW "Verify the clock is running at the desired sample rate with: pw-metadata -n settings | grep clock.rate"

read -p "Press any key to Continue"

FN_PRINT_YELLOW "Open the newly installed program qpwgraph through the search bar or run the command: qpwgraph. This will open a GUI for the PipeWire Graph. You should see all of your devices and how they are connected to each other. This is where you will connect your devices to your DAW by patching I/O to Digital I/O configured in the DAW."

read -p "Press any key to Continue"

FN_PRINT_YELLOW "You set your cards to pro-audio, however, if you reconnect, restart, or reboot the devices or computer, they will revert to their default profile. To have WirePlumber force pro-audio for your device when they connect to your computer, we need to set a WirePlumber rule in a config file:"

echo "mkdir -p ~/.config/wireplumber/wireplumber.conf.d
cat > ~/.config/wireplumber/wireplumber.conf.d/51-pro-audio.conf <<'EOF'
monitor.alsa.rules = [
  {
    matches = [
      { device.name = "<CARD_NAME>" }
    ]
    actions = {
      update-props = {
        device.profile = "<PROFILE_NAME>"
      }
    }
  }
]
EOF"

FN_PRINT_YELLOW "If you have many devices, add them to the 'matches' list with no commas. Restart WirePlumber to load the rule: systemctl --user restart wireplumber. Te verify that the rule is working, power-cycle one of the devices or unplug/replug and check with: wpctl status which should show them loaded in the pro configuration. You can also verify the default profiles are set correctly by running: cat .local/state/wireplumber/default-profile. This will show your cards and their default profile used by wireplumber."

read -p "Press any key to Continue"

FN_PRINT_YELLOW "The rest of this script is Reaper specific but it might have overlap with your DAW."

read -p "Press any key to Continue"

FN_PRINT_YELLOW "Open Reaper and ensure that the Audio Devices are detected and that the sample rate is correct in the top Right corner."

read -p "Press any key to Continue"

FN_PRINT_YELLOW "Go to File -> Project Settings and set the Project Sample Rate to the desired sample rate."

read -p "Press any key to Continue"

FN_PRINT_YELLOW "Go to Options -> Preferences -> Audio -> Device and make sure the audio system is JACK. You should see Reaper appear in the PipeWire Graph, in fact you might have seen it as soon as you opened reaper."

read -p "Press any key to Continue"

FN_PRINT_YELLOW "Set the number of digital input and Output channels you want to have and need to patch to your Audio Devices. This should update in the PipeWire Graph GUI"

read -p "Press any key to Continue"

FN_PRINT_YELLOW "Route your Audio Device's Inputs to Reaper's inputs and route Reaper's outputs to your Devices for Playback etc."

read -p "Press any key to Continue"

FN_PRINT_YELLOW "Create a new Track in Reaper and click to set the input. You should see a list of all of the inputs you routed in the PipeWire Graph which should be connected to your Audio Device. Select a track to test with and Arm Record. You should see audio level in the channel in Reaper. If you don't see any signal, cycle through the different inputs to make sure you are not selecting the wrong input by mistake. Hit Record, and record to your track."

read -p "Press any key to Continue"

FN_PRINT_YELLOW "Play Back what you recorded in your track. If you don't hear anything, go back to the PipeWire Graph and route Reaper's Outputs to different inputs of your Audio Devices until you have monitoring working."

read -p "Press any key to Continue"

FN_PRINT_GREEN_BANNER "You have succesfully Installed and Configured Pro Audio Packages for Ubuntu 26.04!"
