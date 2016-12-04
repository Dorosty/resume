component = require '../../../utils/component'
style = require './style'
overview = require './overview'
scrollViewer = require '../../../components/scrollViewer'
checkbox = require '../../../components/checkbox'
personalInfo = require './personalInfo'
education = require './education'
talents = require './talents'
english = require './english'
reputation = require './reputation'
others = require './others'

module.exports = component 'applicantForm', ({dom}) ->
  {E, show, hide} = dom

  data =
    'مشخصات فردی':
      'جنسیت': 0
      'وضعیت تاهل': 2
  setData = (category) -> (key, value) ->
    data[category] ?= {}
    if value?
      data[category][key] = value
    else
      delete data[category][key]

  view = E null,
    E overview
    scroll = E scrollViewer
    E style.header, 'مشخصات فردی'
    E personalInfo, setData: setData 'مشخصات فردی'
    E style.header, 'سوابق تحصیلی'
    E education, setData: setData 'سوابق تحصیلی'
    E style.header, 'توانمندی‌ها، مهارت‌ها، دانش و شایستگی‌ها'
    E talents, setData: setData 'توانمندی‌ها، مهارت‌ها، دانش و شایستگی‌ها'
    E style.header, 'مهارت زبان انگلیسی'
    E english, setData: setData 'مهارت زبان انگلیسی'
    # E style.header, 'آخرین سوابق سازمانی و پروژه‌ای'
    # E reputation, setData: setData 'آخرین سوابق سازمانی و پروژه‌ای'
    # E style.header, 'سایر اطلاعات'
    # E others, setData: setData 'سایر اطلاعات'
    E style.checkboxWrapper,
      accept = E checkbox, 'صحت اطلاعات تکمیل شده در فرم فوق را تأیید نموده و خود را ملزم به پاسخگویی در برابر صحت اطلاعات آن می‌دانم.'
    hide submit = E style.submit, 'ثبت نهایی اطلاعات'

  accept.onChange ->
    if accept.value()
      show submit
    else
      hide submit

  view