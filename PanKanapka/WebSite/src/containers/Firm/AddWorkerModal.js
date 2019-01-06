import React, { Component } from "react";
import CircularSpinnerLoading from "../CircularSpinnerLoading";
import axios from "axios";

export default class CreateTaskModal extends Component {
    constructor(props) {
        super(props);
        this.state = {
            isLoading: false,
            cateringFirmId:1,
            mail:"",
            password:"",
            name:"",
            surname:"",
        };
    }
    validateForm() {
        return this.state.mail.length > 0 && this.state.password.length > 0;
    }

    handleChange = event => {
        event.preventDefault();
        this.setState({
            [event.target.id]: event.target.value
        });
    }

    handleSubmit = event => {
        
        
        this.setState({ isLoading: true });
        console.log(this.state.name)
        var postData = {
            name:this.state.name,
            surname:this.state.surname,
            mail:this.state.mail,
            password:this.state.password,
            cateringFirmId:this.props.cateringFirmId,
        };
        console.log(this.state)
        axios.post('http://localhost:5000/api/Workers/create', this.state).then(repsonse => {
            if (repsonse.status == 200) {
                window.setTimeout(() => this.props.onClose(true), 1000);
            }
        });
    };


    render() {
        if (this.state.isLoading) {
            return <CircularSpinnerLoading />
        }
        return (
            <div className="Home">
                <div className="lander">
                    <div className="Login">
                        <h1>Dodaj pracownika</h1>
                        <form className="white" onSubmit={this.handleSubmit}>
                        <div className="input-field">
                                <label >Imie</label>
                                <input type="text" id='name' onChange={this.handleChange} />
                            </div>

                            <div className="input-field">
                                <label >Nazwisko</label>
                                <input type="text" id='surname' onChange={this.handleChange} />
                            </div>
                            <div className="input-field">
                                <label >Adress email</label>
                                <input type="email" id='mail' onChange={this.handleChange} />
                            </div>
                            
                            <div className="input-field">
                                <label htmlFor="password">Hasło</label>
                                <input type="password" id='password' onChange={this.handleChange} />
                            </div>

                            <div className="input-field">
                                <button className="btn waves-effect #1a237e indigo darken-4" disabled={!this.validateForm()} type="submit" onChange={this.handleChange}><i className="material-icons right">send</i>Zapisz</button>
                            </div>

                            <div className="center red-text">
                                {this.state.authError ? <p >{this.state.authError}</p> : null}
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        )
    }

}

