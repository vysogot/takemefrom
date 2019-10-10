import React from 'react';
import ReactDOM from 'react-dom';
import CytoscapeComponent from 'react-cytoscapejs';
import Cytoscape from 'cytoscape';
import dagre from 'cytoscape-dagre';

Cytoscape.use(dagre);

function MyApp(props) {
  // const elements = [
  //    { data: { id: 'one', label: 'Node 1' }, position: { x: 0, y: 0 } },
  //    { data: { id: 'two', label: 'Node 2' }, position: { x: 100, y: 0 } },
  //    { data: { source: 'one', target: 'two', label: 'Edge from Node1 to Node2' } }
  // ];

  return [
    <CytoscapeComponent
      elements={props.elements}
      style={{ width: '600px', height: '600px' }}
      layout={{name: 'dagre'}}
    />,
    <pre>{JSON.stringify(props.elements, null, 2)}</pre>
  ];
}

document.addEventListener('DOMContentLoaded', () => {
  const editor = document.getElementById('editor');
  const elements = JSON.parse(editor.dataset.elements);
  ReactDOM.render(
    <MyApp elements={elements} />,
    editor,
  )
})
