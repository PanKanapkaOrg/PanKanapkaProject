import React, { Component } from "react";
import CircularSpinnerLoading from "../CircularSpinnerLoading";
import axios from "axios";

export default class CreateTaskModal extends Component {
    constructor(props) {
        super(props);


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

        var id = event.target.id;
        if (this.state.SelectedFirms.has(id)) {
            this.state.SelectedFirms.delete(id);
        } else {
            this.state.SelectedFirms.add(id);
        }
    }

    handleSubmit = event => {
        var postData = {
            date: this.state.Date,
            workerId: this.state.Worker.id,
            clientFirmIds: Array.from(this.state.SelectedFirms)
        };

        axios.post('http://localhost:5000/api/Tasks/create', [postData]).then(repsonse => {
            if (repsonse.status == 200) {
                this.props.onClose(true);
            }
        });
    };


    render() {
        if (this.state.isLoading) {
            return <CircularSpinnerLoading />
        }
        else {
            return (
                <div className="Home">
                    <div className="lander">
                        <div className="row">
                            <div className="col s12">
                                <h1>Tworzenie nowego zdania dla pracownika</h1>
                            </div>
                            <div className="col s6 lewy">
                                <h4><b>Pracownik:</b></h4>
                            </div>
                            <div className="col s6 prawy">
                                <h4>{this.state.Worker.name}</h4>
                            </div>
                            <div className="col s6 lewy">
                                <h4><b>Data:</b></h4>
                            </div>
                            <div className="col s6 prawy">
                                <h4>{this.state.Date.substring(0, 10)}</h4>
                            </div>
                            <div className="col s12">
                                <h4><b>Firmy</b></h4>
                            </div>
                            {
                                this.state.ClientFirms.map((f) =>
                                    <div className="col s4 firma">
                                        <label>
                                            <input type="checkbox" key={f.id} id={f.id} onChange={this.toggleCheckbox} />
                                            <span><h5 className="firmName">{f.name}</h5></span>
                                        </label>
                                    </div>
                                )
                            }
                            <div className="col s2 offset-s5">
                                <button
                                    className="btn waves-effect #1a237e indigo darken-4 zapisz"
                                    type="submit"
                                    onClick={this.handleSubmit}
                                ><i className="material-icons right">send</i>Zapisz</button>
                            </div>
                        </div>

                       
                        <div className="div_zamknij">
                        <button
                            className="zamknij"
                            onClick={() => {
                                this.props.onClose(false)
                            }}><i className="material-icons center">close</i></button>

                        </div>



                    </div>
                </div>

            );
        }
    }

}

