import os
import time
from openai import OpenAI
import OpenEXR
import Imath
import array

def openai_chat():
    client = OpenAI(
    # This is the default and can be omitted
    api_key=os.environ.get("OPENAI_API_KEY"),
    )
    try:
        print("Opening OpenAI chat...")
        chat_completion = client.chat.completions.create(
            messages=[
                {
                    "role": "user",
                    "content": "Say this is a test",
                }
            ],
            model="gpt-3.5-turbo",
        )
    except:
        return False

def openexr_demo():
    width = 10
    height = 10
    size = width * height

    h = OpenEXR.Header(width,height)
    h['channels'] = {'R' : Imath.Channel(FLOAT),
                    'G' : Imath.Channel(FLOAT),
                    'B' : Imath.Channel(FLOAT),
                    'A' : Imath.Channel(FLOAT)} 
    o = OpenEXR.OutputFile("hello.exr", h)
    r = array('f', [n for n in range(size*0,size*1)]).tobytes()
    g = array('f', [n for n in range(size*1,size*2)]).tobytes()
    b = array('f', [n for n in range(size*2,size*3)]).tobytes()
    a = array('f', [n for n in range(size*3,size*4)]).tobytes()
    channels = {'R' : r, 'G' : g, 'B' : b, 'A' : a}
    o.writePixels(channels)
    o.close()
    
while(True):
    if openai_chat():
        break
    else:
        print("Sleeping for 30 seconds...")
        time.sleep(30)
        openexr_demo
        continue
