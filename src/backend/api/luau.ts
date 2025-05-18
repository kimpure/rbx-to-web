import { spawn } from "child_process";

export default function() {
    spawn('lune', ['run', 'src/backend/api']);
}