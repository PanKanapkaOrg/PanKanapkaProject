import React, { Component } from "react";
import axios from "axios"
import "./plans.css"
export default class CreateTaskModal extends Component {
    constructor(props) {
        super(props);
        this.state = {
            confirmed: false,
        };
    }
    handleSubmit=()=>{
        console.log(this.props.id)
        axios.post('http://localhost:5000/api/Tasks/delete', [this.props.id]).then(repsonse => {
            if (repsonse.status == 200) {
                console.log("done")
                this.props.onClose(true);
            }
        });
    }

    render() {
        return (
            <div className="Home">
                <div className="lander">
                    <p>Czy jesteś pewien, że chcesz usunąć to zadadnie?</p>
                    <div className="col s12">
                        <button
                            className="btn waves-effect #1a237e indigo darken-4 zapisz"
                            type="submit"
                            onClick={this.handleSubmit}
                        ><i className="material-icons right">send</i>Ok</button>
                        <button
                            className="btn waves-effect #1a237e red darken-4 zapisz"
                            type="submit"
                            onClick={()=>{this.props.onClose(false)}}
                        ><i className="material-icons right">cancel</i>Anuluj</button>
                    </div>

                </div>
            </div>
        )
    }
}