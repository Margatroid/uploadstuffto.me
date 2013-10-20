class EditMode
  setup: =>
    $('.tile').click(this.tileOnClick)
    $('.tile-select').change(this.tileSelectOnChange)
    $('.select-all, .deselect-all').click(this.toggleAllTiles)
    $('.select-all, .deselect-all').removeAttr('disabled')

  onLoad: =>
    this.setup() if $('.leave-edit-mode').length

  # Make entire tile behave like the checkbox.
  tileOnClick: (event) =>
    $target = $(event.target)
    return if $target.hasClass('tile-select')
    event.preventDefault()

    if $target.hasClass('tile')
      checkbox = $target.find('.tile-select')
    else
      checkbox = $target.parents('.tile').find('.tile-select')

    checkbox.prop('checked', !checkbox.prop('checked'))
    checkbox.change()

  # Change colouring of entire tile when checkbox is ticked.
  tileSelectOnChange: (event) =>
    $tile = $(event.target).parent('.tile')
    if $(event.target).is(':checked')
      $tile.addClass('checked')
    else
      $tile.removeClass('checked')

  toggleAllTiles: (event) =>
    event.preventDefault()
    $button = $(event.target)
    checkAll = ($button.hasClass('select-all')) ? true : false

    $('.tile-select').each (i) ->
      checkbox = $(this)
      checkbox.prop('checked', checkAll)
      checkbox.change()

this.EditMode = EditMode