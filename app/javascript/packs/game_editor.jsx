import React from 'react'
import ReactDOM from 'react-dom'
import CytoscapeComponent from 'react-cytoscapejs';

class MyApp extends React.Component {
  constructor(props){
    super(props);
  }

  render(){
    // const elements = [
    //    { data: { id: 'one', label: 'Node 1' }, position: { x: 0, y: 0 } },
    //    { data: { id: 'two', label: 'Node 2' }, position: { x: 100, y: 0 } },
    //    { data: { source: 'one', target: 'two', label: 'Edge from Node1 to Node2' } }
    // ];

    return [
      <pre>{JSON.stringify(this.props.elements, null, 2)}</pre>,
      <CytoscapeComponent elements={this.props.elements} style={ { width: '1200px', height: '1200px' } } />
    ];
  }
}

document.addEventListener('DOMContentLoaded', () => {
  const editor = document.getElementById('editor');
  const elements = JSON.parse(editor.dataset.elements);
  ReactDOM.render(
    <MyApp elements={elements} />,
    editor,
  )
})
