import React, { Component } from 'react';
import axios from 'axios'
import ReactTable from 'react-table'

class GetFoods extends Component {
    constructor(props)
    {
        super(props);
        this.state = {
          tableData: [{
          }],
      };
    }

    componentDidMount () {
      axios.get('http://localhost:5000/api/foods/'+this.props.cateringFirmId, {
          responseType: 'json'
      }).then(response => {
          this.setState({ tableData: response.data });
      });
  }

  render () {
    const { tableData } = this.state;

    const columns = [{
      Header: 'Id',
      accessor: 'foodId'
    }, 
    {
      Header: 'Name',
      accessor: 'name',
    }, 
    {
      Header: 'Price',
      accessor: 'price'
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

export default GetFoods;
