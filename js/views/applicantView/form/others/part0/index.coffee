component = require '../../../../../utils/component'
style = require './style'
dropdown = require '../../../../../components/dropdown'
dateInput = require '../../../../../components/dateInput'
numberInput = require '../../../../../components/restrictedInput/number'
{extend, remove} = require '../../../../../utils'

module.exports = component 'applicantFormOthersPart0', ({dom, events}, {setData, registerErrorField, setError}) ->
  {E, text, setStyle, show, hide} = dom
  {onEvent} = events

  labels = {}
  fields = {}
  incomeError = sayerError = undefined

  fields['متقاضی چه نوع همکاری هستید'] = f = E dropdown, items: ['تمام وقت', 'پاره وقت', 'مشاوره‌ای - ساعتی', 'پیمانکاری']
  setStyle f, style.dropdownPlaceholder
  setStyle f.input, style.dropdown

  f0 = E null, do ->
    fields['از چه طریقی از فرصت شغلی در داتین مطلع شدید'] = x = E dropdown, items: ['نمایشگاه/همایش/کنفرانس', 'آگهی', 'سایت داتین', 'دوستان و همکاران', 'سایر']
    setStyle x, style.dropdownPlaceholder
    setStyle x.input, style.dropdown
    hide y = fields['از چه طریقی از فرصت شغلی در داتین مطلع شدید - سایر'] = E 'input', extend {placeholder: 'توضیحات...'}, style.descriptionInput
    labels['از چه طریقی از فرصت شغلی در داتین مطلع شدید - سایر'] = E()
    x.onChange ->
      if x.value() is 'سایر'
        show y
        setData 'از چه طریقی از فرصت شغلی در داتین مطلع شدید - سایر', y.value()
        unless y.value()
          setError sayerError, 'تکمیل این فیلد الزامیست.', true
      else
        hide y
        setData 'از چه طریقی از فرصت شغلی در داتین مطلع شدید - سایر', null
        setError sayerError, null
    [x, y]

  fields['از چه تاریخی می‌توانید همکاری خود را با داتین آغاز کنید'] = f = E dateInput
  setStyle f, style.dateInputPlaceholder
  setStyle f.input, style.dateInput

  f1 = E null, do ->
    fields['میزان دستمزد'] = x = E dropdown, items: ['طبق قانون کار', 'قابل مذاکره', 'مقدار مشخص']
    setStyle x, style.dropdownPlaceholder
    setStyle x.input, style.dropdown
    hide y = fields['مقدار دستمزد'] = E numberInput
    setStyle y, style.descriptionInput
    hide z = labels['مقدار دستمزد'] = E style.inlineLabel, 'ریال'
    x.onChange ->
      if x.value() is 'مقدار مشخص'
        show [y, z]
        setData 'مقدار دستمزد', y.value()
        unless y.value()
          setError incomeError, 'تکمیل این فیلد الزامیست.', true
      else
        hide [y, z]
        setData 'مقدار دستمزد', null
        setError incomeError, null
    [x, y, z]

  view = E null,
    E style.column,
      labels['متقاضی چه نوع همکاری هستید'] = E style.label, 'متقاضی چه نوع همکاری هستید؟'
      fields['متقاضی چه نوع همکاری هستید']
      labels['از چه طریقی از فرصت شغلی در داتین مطلع شدید'] = E style.label, 'از چه طریقی از فرصت شغلی در داتین مطلع شدید؟'
      f0
      labels['از چه تاریخی می‌توانید همکاری خود را با داتین آغاز کنید'] = E style.label, 'از چه تاریخی می‌توانید همکاری خود را با داتین آغاز کنید؟'
      fields['از چه تاریخی می‌توانید همکاری خود را با داتین آغاز کنید']
    E style.column,
      E style.label,
        labels['نوع بیمه‌ای که تا‌به‌حال داشته‌اید'] = E 'span', null, 'نوع بیمه‌ای که تا‌به‌حال داشته‌اید؟'
        E style.optional, '(اختیاری)'
      fields['نوع بیمه‌ای که تا‌به‌حال داشته‌اید'] = E 'input', style.input
      E style.label,
        labels['مدت زمانی که بیمه بوده‌اید'] = E 'span', null, 'مدت زمانی که بیمه بوده‌اید؟'
        E style.optional, '(اختیاری)'
      fields['مدت زمانی که بیمه بوده‌اید'] = E 'input', style.input
      labels['میزان دستمزد'] = E style.label,
        text 'میزان دستمزد '
        E style.underline, 'خالص'
        text ' درخواستی شما چقدر است؟'
      f1
    E style.clearfix

  hideTooltips = []
  Object.keys(fields).forEach (fieldName) ->
    label = labels[fieldName]
    field = fields[fieldName]
    if fieldName in ['نوع بیمه‌ای که تا‌به‌حال داشته‌اید', 'مدت زمانی که بیمه بوده‌اید']
      if field.onChange
        field.onChange ->
          setData fieldName, field.value()
      else
        input = field.input || field
        onEvent input, ['input', 'pInput'], ->
          setData fieldName, field.value()
      return
    error = registerErrorField label, field
    unless fieldName is 'مقدار دستمزد'
      setError error, 'تکمیل این فیلد الزامیست.', true
    if fieldName is 'مقدار دستمزد'
      incomeError = error
    if fieldName is 'از چه طریقی از فرصت شغلی در داتین مطلع شدید - سایر'
      sayerError = error
    if field.onChange
      field.onChange ->
        setData fieldName, field.value()
      onEvent field.input, 'input', ->
        setError error, 'تکمیل این فیلد الزامیست.', true
      onEvent field.input, 'blur', ->
        setTimeout ->
          if !field.value()?
            setError error, 'تکمیل این فیلد الزامیست.'
          else
            setError error, null
    else
      input = field.input || field
      onEvent input, ['input', 'pInput'], ->
        setData fieldName, field.value()
      handleChange = (hidden) -> ->
        if !field.value().trim()
          setError error, 'تکمیل این فیلد الزامیست.', hidden
        else if field.valid? && !field.valid()
          setError error, 'مقدار وارد شده قابل قبول نیست.', hidden
        else
          setError error, null
      onEvent input, ['input', 'pInput'], handleChange true
      onEvent input, 'blur', handleChange false

  view