from subprocess import check_output, STDOUT
from time import time

class Py3status:
    cache_timeout = 1

    def language(self, i3s_output_list, i3s_config):
        lan = int(check_output(["xset","-q"], stderr=STDOUT).decode("UTF-8").split('\n')[1].split(' ')[-1])

        text = 'Hebrew' if lan >= 1000 else 'English' 
        response = {
            'cached_until': time() + self.cache_timeout,
            'full_text': ''
        }

        response['full_text'] = text if ((lan & 1) == 0) else text.upper()
        if (lan & 2) == 0:
            response['color'] = '#FF0000' 
        return response
