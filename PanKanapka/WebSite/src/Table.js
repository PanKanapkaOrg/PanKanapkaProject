import React, { Component } from 'react';
import axios from 'axios'
import ReactTable from 'react-table'

class Table extends Component {
    constructor()
    {
        super();
        this.state = {
          tableData: [{
              FoodId : '',
              Price: '',
              Name: '',
              Description: '',
              ImageURL: '',
              IsVegan: ''
          }],
      };
    }

    componentDidMount () {
      axios.get('http://localhost:5000/api/foods/1', {
          responseType: 'json'
      }).then(response => {
          this.setState({ tableData: response.data });
      });
  }


  render () {
    const { tableData } = this.state;
    
    console.log(tableData[0].Price);

    const columns = [{
      Header: 'Id',
      accessor: 'foodId' // String-based value accessors!
    }, 
    {
      Header: 'Name',
      accessor: 'name',
      //Cell: props => <span className='number'>{props.value}</span> // Custom cell components!
    }, 
    {
      Header: 'Price',
      accessor: 'price' // Custom value accessors!
    }]


    return (<ReactTable
                    data={tableData}
                    columns={columns}
                    defaultPageSize={10}
                    className="-striped -highlight"
            />
    );
  }
}

export default Table;
