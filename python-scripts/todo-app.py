#!/usr/bin/env python
# coding: utf-8

# In[1]:


from PySimpleGUI import Window, Text, Button, CBox, Input, change_look_and_feel

change_look_and_feel('DarkAmber')   # Add a little color for fun

layout =  [[Text('My To Do List', font='Helvetica 15')]]  # a title line t
layout += [[Text(f'{i}. '), CBox(''), Input()] for i in range(1, 6)]  # the checkboxes and descriptions
layout += [[Button('Save'), Button('Load'), Button('Exit')]]  # the buttons

window = Window('To Do List Example', layout)

while True:
    event, values = window.read()
    if event in (None, 'Exit'):
        break
    elif event == 'Save':
        window.save_to_disk('mywindow.out')
    elif event == 'Load':
        window.load_from_disk('mywindow.out')
window.close()


# In[ ]:




