import React, { Component } from "react";
import GetTasks from "../services/api/GetTasks";
import GetClientFirms from "../services/api/GetClientFirms";
import GetWorkers from "../services/api/GetWorkers";
import CircularSpinnerLoading from "../CircularSpinnerLoading";
import Modal from 'react-modal';
import CreateTaskModal from "./CreateTaskModal"
import "./plans.css";

export default class Plans extends Component {
    constructor(props) {
        super(props);

        this.state = {
            isLoading: true,
            ClientFirms: [],
            Workers: [],
            Tasks: [],
            UnusedFirms: new Map(),

            isModalDisplay: false,
            choosenWorker: null,
            choosenDate: null,
            choosenFirms: null,
            display:null,
        };
    }

    loadTasks = () => {
        this.setState({ isLoading: true });

        GetClientFirms(this.props)
            .then(firms => this.setState({ ClientFirms: firms }));
        GetWorkers(this.props)
            .then(workers => {
                var taskFilter = {
                    WorkerIds: workers.map(w => w.id),
                    Date: "2018-10-27",
                    DaysBefore: 3,
                    DaysAfter: 3
                }

                GetTasks(taskFilter)
                    .then(tasks => {
                        window.setTimeout(() => this.setState({ Tasks: tasks.data, Workers: workers, isLoading: false }), 1500);
                    });
            });
    }

    componentDidMount() {
        this.loadTasks();
    }

    closeModal = (reload) =>{ 
        this.setState({
            isModalDisplay : false,
            display: null   
        });
        if(reload)
        {
            this.loadTasks();
        }
    }

    render() {
        if (this.state.isLoading) {
            return <CircularSpinnerLoading />
        }
        else {
            // console.log("Tasks is = ", Array.isArray(this.state.Tasks));
            // if (Array.isArray(this.state.Tasks)) {
            //     console.log(this.state.ClientFirms);
            //     console.log(this.state.Tasks);
            // }

            this.state.UnusedFirms.clear();

            this.state.Tasks[0].taskItems.forEach((item) => {
                this.state.UnusedFirms.set(item.date, this.state.ClientFirms);
            });
            return (
                <div className="Home">
                    <div className="lander">
                        <h1>Plany dla pracowników</h1><br></br>

                        <table className="highlight centered">
                            <thead>
                                <tr>
                                    <th>Pracownik</th>
                                    {
                                        this.state.Tasks[0].taskItems.map((item) =>
                                            <th>
                                                {item.date.substring(0, 10)}
                                            </th>
                                        )
                                    }
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    this.state.Tasks.map((task) =>
                                        <tr>

                                            <td>
                                                {task.worker.name} {task.worker.surname}
                                            </td>
                                            {
                                                task.taskItems.map((taskItem) => {
                                                    var newArray = this.state.UnusedFirms.get(taskItem.date).filter(item => {
                                                        //console.log("item id = ", item.id);
                                                        return -1 === taskItem.firms.findIndex(firm => firm.id == item.id);
                                                    });
                                                    this.state.UnusedFirms.set(taskItem.date, newArray);
                                                    console.log("Unsused firms = ", taskItem.date, newArray, task.worker.name);

                                                
                                                    return (<td className="komorka">
                                                        <ul>
                                                            {taskItem.firms.map((firm) => {
                                                                return (<li>{firm.name}</li>)
                                                            }
                                                            )}
                                                        </ul>
                                                        <button
                                                            className="btn waves-effect #1a237e indigo darken-4 add-plan"
                                                            style={{display:this.state.display}}
                                                            onClick={() => {
                                                                this.setState({ display:'none', isModalDisplay: true, choosenWorker: task.worker, choosenDate: taskItem.date, choosenFirms: this.state.UnusedFirms.get(taskItem.date) })
                                                            }}><i className="material-icons center">add</i></button>
                                                    </td>)
                                                }
                                                )
                                            }
                                        </tr>
                                    )
                                }
                            </tbody>
                        </table>

                        <Modal
                            isOpen={this.state.isModalDisplay}
                            contentLabel="Example Modal">
                            <CreateTaskModal
                                worker={this.state.choosenWorker}
                                date={this.state.choosenDate}
                                clientFirms={this.state.choosenFirms}
                                onClose={(reload) => this.closeModal(reload)} />
                        </Modal>
                    </div>
                </div>
            );
        }
    }
}