#!/usr/bin/python3

import dbus
from sys import argv

trunclen = 30

try:
    session_bus = dbus.SessionBus()
    spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2")

    interface = dbus.Interface(spotify_bus,
            dbus_interface='org.mpris.MediaPlayer2.Player')

    if len(argv) > 1:
        if "pause" in argv[1]:
            interface.PlayPause()
        elif "next" in argv[1]:
            interface.Next()

    spotify_properties = dbus.Interface(spotify_bus, "org.freedesktop.DBus.Properties")
    metadata = spotify_properties.Get("org.mpris.MediaPlayer2.Player", "Metadata")
    status = spotify_properties.Get(
            "org.mpris.MediaPlayer2.Player", "PlaybackStatus"
            )

    artist = metadata['xesam:artist'][0]
    song = metadata['xesam:title']

    if len(song) > trunclen:
        song = song[0:trunclen]
        song += '...' 
        if ('(' in song) and (')' not in song):
            song += ')'

    output = artist + ': ' + song
    print(output)
except:
    print("")
