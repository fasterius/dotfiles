// Rings the terminal bell when a session finishes or needs attention

export default {
    id: "session-bell",
    tui: async (api) => {
        const bell = () => process.stdout.write("\x07")
        const busy = new Set()
        const asked = new Set()

        const ask = (event) => {
            if (asked.has(event.properties.id)) return
            asked.add(event.properties.id)
            bell()
        }
        api.event.on("question.asked", ask)
        api.event.on("permission.asked", ask)

        // Only top-level sessions, as subagents finish while the agent works
        api.event.on("session.status", (event) => {
            const { sessionID, status } = event.properties
            if (status.type !== "idle") return void busy.add(sessionID)
            if (!busy.delete(sessionID)) return
            if (api.state.session.get(sessionID)?.parentID === undefined) bell()
        })
    },
}
