$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'),
    dataType: 'json'
  }
});

function placeUpdate(placeId, content, isDestroyable) {
  removeLink = "";
  if (!isDestroyable) {
    removeLink = '<a id="remove" data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/places/' + placeId + '">Destroy</a>'
  }

  $('#theBox').html(
    '<a href="javascript:setConnection(\''+placeId+'\');">Connect</a> ' +
     removeLink + '<form>' +
    '<br/><textarea name="content" id="content">' + content + '</textarea><br />' +
    '<input data-turbolinks="false" type="button" value="Submit" id="submit" /> ' +
    '<a href="/places/'+placeId+'">Play</a></form>'
  );

  $('#submit').attr('disabled', 'disabled');
  $('#content').on('input', function() {
    $('#submit').removeAttr('disabled');
  });

  $("#submit").click(function() {
    content = $('#content').val();
    $.ajax({
      url: '/places/' + placeId,
      data: { "place[content]": content },
      method: 'PUT'
    }).done(function(response) {

      newContent = response.updatedNodeContent;
      nodeToUpdate = nodes.filter(function(element, index) {
        return (element.data.id === placeId)
      })[0];

      nodeToUpdate.data.content = newContent;
      $('#theBox').animate({ opacity: 0 }, 500, function() {
        $('#theBox').animate({ opacity: 1 }, 500);
        placeUpdate(placeId, newContent, isDestroyable);
      });
    });
  });
}

function choiceUpdate(choiceId, content) {
  choiceId = choiceId.replace( /^edge\-/g, '');
  $('#theBox').html(
    '<a id="remove" href="/choices/'+choiceId+'/destroy" onclick="return confirm(\'Are you sure?\')">Remove</a>' +
    '<form choice="/choices/'+choiceId+'/update" method="put">' +
      '<br/><textarea name="content">' + content + '</textarea><br />' +
      '<input type="submit" value="Submit" /> ' +
    '</form>'
  );
}

function addNewPlace(fromPlaceId) {
  $.ajax({
    url: "/places",
    data: { "place[from_place_id]": fromPlaceId },
    dataType: 'json',
    method: 'POST'
  }).done(function(response) {
    nodes.push({ data: response.newNode });
    edges.push({ data: response.newEdge });
    makeGraph();
  });
}

function addNewEdge(fromPlaceId, toPlaceId) {
  $.ajax({
    url: "/choices",
    data: { "choice[source_id]": fromPlaceId, "choice[target_id]": toPlaceId },
    method: 'POST'
  }).done(function(response) {
    edges.push({ data: response.newEdge });
    makeGraph();
  });
}
