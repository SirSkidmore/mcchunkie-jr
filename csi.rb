# -*- coding: utf-8 -*-
class CSIPlugin < Plugin
  def self.yeah
    wait = 1.0/2.0
    self.send_message('( •_•)')
    sleep(wait)
    self.send_message('( •_•)>⌐■-■')
    sleep(wait)
    self.send_message('(⌐■_■)')
    sleep(wait)
    self.send_message('YEEAAAAAHHHHHH!')
  end
end
