-- CreateTable
CREATE TABLE "Percepatan" (
    "id" SERIAL NOT NULL,
    "tanggal" TIMESTAMP(3) NOT NULL,
    "sessionId" INTEGER NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Percepatan_sessionId_unique" ON "Percepatan"("sessionId");

-- AddForeignKey
ALTER TABLE "Percepatan" ADD FOREIGN KEY ("sessionId") REFERENCES "Session"("id") ON DELETE CASCADE ON UPDATE CASCADE;
