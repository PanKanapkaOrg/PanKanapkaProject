import React, { Component } from "react";
import CircularSpinnerLoading from "../CircularSpinnerLoading";
import axios from "axios";

export default class CreateTaskModal extends Component {
    constructor(props) {
        super(props);

        console.log(props);

        this.state = {
            isLoading: false,
            ClientFirms: props.clientFirms,
            Worker: props.worker,
            Date: props.date,
            SelectedFirms: new Set()
        };
    }

    toggleCheckbox = event => {
        event.preventDefault();

        console.log(event.target.id);
        var id = event.target.id;
        if (this.state.SelectedFirms.has(id)) {
            this.state.SelectedFirms.delete(id);
        } else {
            this.state.SelectedFirms.add(id);
        }
        console.log(this.state.SelectedFirms);
    }

    handleSubmit = event => {
        var postData = {
            date : this.state.Date,
            workerId: this.state.Worker.id,
            clientFirmIds: Array.from(this.state.SelectedFirms)
        };
        console.log(postData);

        axios.post('http://localhost:5000/api/Tasks/create', [ postData ]).then(repsonse => {
            console.log(repsonse);    
        if(repsonse.status == 200) {
                this.props.onClose();
            }
        });
    };
    

    render() {
        if (this.state.isLoading) {
            return <CircularSpinnerLoading />
        }
        else {

            console.log(this.state.SelectedFirms);

            return (
                <div>

                    <h1>{this.state.Worker.name} {this.state.Date}</h1>
                    <div>
                        <h1>Firmy</h1>
                        {
                            this.state.ClientFirms.map((f) =>
                                <p>
                                    <label>
                                        <input type="checkbox" id={f.id} onChange={this.toggleCheckbox} />
                                        <span>{f.name}</span>
                                    </label>
                                </p>
                            )
                        }
                    </div>

                    <button
                        className="btn waves-effect #1a237e indigo darken-4"
                        onClick={() => {
                            this.props.onClose()
                        }}><i className="material-icons center">add</i>Zamknij</button>
                        
                        
                        
                        
                    <button 
                        className="btn waves-effect #1a237e indigo darken-4" 
                        type="submit"
                        onClick={this.handleSubmit} 
                        ><i className="material-icons right">send</i>Zapisz</button>

                </div>

            );
        }
    }

}

