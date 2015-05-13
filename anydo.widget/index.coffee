# Mislav Cimpersak
# 2015
# mislav.cimpersak@gmail.com

# INSERT YOUR NAME AND PASSWORD HERE
username = ''  # 'username@domain.com'
password = ''  # 'password'

command: "python ./anydo.widget/get_anydo.py #{username} #{password}"

refreshFrequency: 300000 # ms (5 minutes)

style: """
  width: 100%
  left: 60px
  top: 30px
  color: #000
  overflow: hidden
  max-width: 300px
  background: rgba(#000, 0.3)
  border-radius: 5px
  color: #ddd
  font-family: 'Roboto Condensed', sans-serif
  -webkit-font-smoothing: antialiased

  .tasks
    list-style-type: none
    padding: 0
    margin: 5

  .task
    list-style: none
    float: left
    width: 100%
    height: auto
    display: inline-block
    padding: 10px 20px
    border-bottom: 1px solid rgba(255, 255, 255, 0.3)
  
  .title
    white-space: nowrap
    text-overflow: ellipsis
    overflow: hidden

    .priority-icon
      margin-right: 9px

    .task-checked
      text-decoration: line-through
      color: #a3a3a3

    .refresh-icon
      margin-left: 9px
      font-size: 12px

  .alert
    font-weight: 800
    font-size: 12px
    opacity: 0.8
    margin-left: 10px
    margin-top: 5px

    .alert-icon
      margin-right: 9px

  .cf:before,
  .cf:after
    content: " ";
    display: table;
  .cf:after
    clear: both
"""

# Render the output
render: -> """
  <link href='http://fonts.googleapis.com/css?family=Roboto+Condensed:400,700' rel='stylesheet' type='text/css'>
  <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

  <ul class="tasks cf">
  </ul>
  """

update: (output, domEl) -> 
  dom = $(domEl)
  
  # parse the JSON created by the shell script
  try
    data = JSON.parse(output)
    html = ""
  catch error
    html = "<li class='task'>" + output + "</li>"
    data

  # check if data is empty
  if data
    if data.length == 0
      html += "<li class='task'>Hooray! No tasks here &nbsp;<i class='fa fa-check'></i></li>"

    # loop through the services in the JSON.
    for task in data
      # start building single task list item
      html += "<li class='task'>" 

      html += "<div class='title'>"

      # add high priority icon
      if task.priority == 'High'
        html += "<i class='priority-icon fa fa-flash'></i>"

      if task.status == 'CHECKED'
        html += "<span class='task-checked'>"

      html += task.title
      if task.status == 'CHECKED'
        html += "</span>"

      # check if task is repeating
      if task.repeatingMethod != 'TASK_REPEAT_OFF'
        html += "<i class='refresh-icon fa fa-recycle'></i>"

      html += "</div>"

      # check for alerts
      if task.hasOwnProperty('alert')
        alert = task.alert
        if alert.hasOwnProperty('type')
          if alert.type == 'OFFSET'
            html += "<div class='alert'><i class='alert-icon fa fa-bell-o'></i>"
            if task.alert.repeatStartsOn?
              html += task.alert.repeatStartsOn
            else
              html += task.dueDate
            html += "</div>"

      html += "</li>"
      # end of single task list item

  # Set our output.
  $('.tasks').html(html)
