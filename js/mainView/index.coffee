component = require '../utils/component'
style = require './style'
{extend, toDate, collection} = require '../utils'

stateToPersian = (state) ->
  switch state
    when 0
      'ثبت شده'
    when 1
      'تایید اولیه توسط مدیر'
    when 2
      'مصاحبه تلفنی انجام شده'
    when 3
      'اطلاعات تکمیل شده'
    when 4
      'آزمون‌های شخصیت‌شناسی داده شده'
    when 5
      'مصاحبه فنی برگزار شده'
    when 6
      'کمیته جذب برگزار شده'
    when 7
      'جذب شده'
    when 8
      'بایگانی'

module.exports = component 'mainView', ({dom, events, state}) ->

  {E, append, destroy, setStyle} = dom
  {onEvent} = events

  view = E null,
    E style.header,
      E 'img', style.headerImg
      E style.headerWrapper,
        E style.headerTitle, 'انتخاب شغل‌های مورد تقاضا'
        E style.breadcrumbs,
          E 'a', extend({href: 'Home'}, style.breadcrumbsLink), 'خانه > '
          E 'a', extend({href: '#'}, style.breadcrumbsLinkActive), 'انتخاب شغل‌های مورد تقاضا'
    E style.wrapper,
      E style.title, 'انتخاب شغل‌های مورد تقاضا'
      E 'table', style.table,
        E 'thead', null,
          E 'th', extend({minWidth: 65}, style.th)
          E 'th', style.th,
            E style.thSpan, 'نام'
            searchFirstName = E 'input', placeholder:'جستجو...', class: 'form-control'
          E 'th', style.th,
            E style.thSpan, 'نام خانوادگی'
            searchLastName = E 'input', placeholder:'جستجو...', class: 'form-control'
          E 'th', style.th, 'تاریخ تولد'
          E 'th', style.th,
            E style.thSpan, 'مشاغل درخواستی'
            searchJobs = E 'input', placeholder:'جستجو...', class: 'form-control'
          E 'th', style.th, 'تاریخ ثبت'
          E 'th', style.th, 'تلفن همراه'
          E 'th', style.th, 'ایمیل'
          E 'th', style.th, 'رزومه'
          E 'th', style.th, 'اطباعات تکمیل شده'
          E 'th', style.th, 'نتیجه آزمونها'
          E 'th', extend({minWidth: 100}, style.th), 'وضعیت'
          # E 'th', extend({minWidth: 50}, style.th), 'تایید‌/رد'
        tbody = E 'tbody'

  addApplication = (application) ->
    append tbody, row = E 'tr', style.tr,
      E 'td', style.td,
        img = E 'img', extend {src: application.picture or 'img/picicon.png'}, style.tdPicture
      firstName = E 'td', style.td, application.firstName
      lastName = E 'td', style.td, application.lastName
      birthday = E 'td', style.td, application.birthday
      jobs = E 'td', style.td, application.jobs
      createdAt = E 'td', style.td, toDate application.createdAt
      phoneNumber = E 'td', style.td, application.phoneNumber
      email = E 'td', extend {englishText: application.email}, style.td
      E 'td', style.td,
        resume = E 'a', href: application.resumeUrl,
          E 'i', extend {class: 'fa fa-paperclip'}, style.tdPaperclip
      E 'td', style.td,
        E 'a', href: '',
          E 'i', extend {class: 'fa fa-paperclip'}, style.tdPaperclip
      E 'td', style.td,
        E 'a', href: '',
          E 'i', extend {class: 'fa fa-paperclip'}, style.tdPaperclip
      state = E 'td', style.td, stateToPersian application.state

    {row, img, firstName, lastName, birthday, jobs, createdAt, phoneNumber, email, resume, state}

  removeApplication = ({row}) ->
    destroy row

  changeApplication = (application, x) ->
    {img, firstName, lastName, birthday, jobs, createdAt, phoneNumber, email, resume, state} = x
    setStyle img, src: application.picture or 'img/picicon.png'
    setStyle firstName, text: application.firstName
    setStyle lastName, text: application.lastName
    setStyle birthday, text: application.birthday
    setStyle jobs, text: application.jobs
    setStyle createdAt, text: toDate application.createdAt
    setStyle phoneNumber, text: application.phoneNumber
    setStyle email , englishText: application.email
    setStyle resume , href: application.resumeUrl
    setStyle state , text: stateToPersian application.state
    x

  handleApplications = collection addApplication, removeApplication, changeApplication

  searchInputs =
    'firstName': searchFirstName
    'lastName': searchLastName
    'jobs': searchJobs

  updateTable = ->
    filteredApplications = applications
    Object.keys(searchInputs).forEach (key) ->
      value = String searchInputs[key].element.value
      if value.trim() is ''
        return
      words = value.split ' '
      .map (word) -> word.trim().toLowerCase();
      .filter (word) -> word
      filteredApplications = filteredApplications.filter (application) ->
        words.some (word) -> ~application[key].toLowerCase().indexOf word
    handleApplications filteredApplications

  applications = undefined
  state.applications.on (_applications) ->
    applications = _applications
    handleApplications applications

  Object.keys(searchInputs).forEach (key) ->
    onEvent searchInputs[key], 'input', updateTable

  view