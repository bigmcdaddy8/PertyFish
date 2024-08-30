# Chess Engine Development Notes

## Development Process
- build engines that can beat the previous engine
- focus on chess game in reverse chronological order - end to beginning
- - focus on what is effective against single king

### fCE_300 (Preschool) development
- focus on chess game in reverse chronological order - end to beginning
- - focus on what is effective against single king
- - - advance isolated pawns moving to unattacked squares +25 centipawns
- - - increase in number of king surround squares attack percentage (number of squares surrounding the king plus the square the king is on) +25 centipawns
- - - - use percentage because the number of square surrounding a king depends upon is location on the board
- - - - do not count if within reach of the king
- general play improvment
- - look for pieces that can be attacked but do not attack back (i.e., from a square that is not attacked)


## Frozen as of 8/29/2024
- fCE_100 (Random)
- fCE_200 (Bully)

- develop Preschool to beat bully

## Head to Head Results
- Date: 8/29/2024 White: Random Black: Bully Results:  0 - 3 - 7   Rules: 200 move limit